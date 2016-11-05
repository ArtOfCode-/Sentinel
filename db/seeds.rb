# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

feedback_types = [
    {
        name: 'true positive',
        short_code: 'tp',
        character: '✓',
        color: '#05720b'
    },
    {
        name: 'false positive',
        short_code: 'fp',
        character: '✗',
        color: '#910000'
    },
    {
        name: 'true negative',
        short_code: 'tn',
        character: '⚠',
        color: '#d6b200'
    },
    {
        name: 'needs edit',
        short_code: 'ne',
        character: '✎',
        color: '#008bd6'
    }
]
FeedbackType.create(feedback_types)
