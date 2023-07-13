Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEBE752432
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjGMNuE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGMNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:50:02 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 06:50:01 PDT
Received: from de-smtp-delivery-104.mimecast.com (de-smtp-delivery-104.mimecast.com [194.104.111.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4611995
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:50:01 -0700 (PDT)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.53
 [104.47.14.53]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-QlXDaC8rMIC3WCpkkWIeOA-1; Thu, 13 Jul 2023 15:48:08 +0200
X-MC-Unique: QlXDaC8rMIC3WCpkkWIeOA-1
Received: from AS9PR05CA0251.eurprd05.prod.outlook.com (2603:10a6:20b:493::10)
 by AM8PR06MB7602.eurprd06.prod.outlook.com (2603:10a6:20b:363::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 13:48:01 +0000
Received: from VI1EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:493:cafe::2f) by AS9PR05CA0251.outlook.office365.com
 (2603:10a6:20b:493::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Thu, 13 Jul 2023 13:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 194.34.82.153) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com
Received: from astrazenecatst.com (194.34.82.153) by
 VI1EUR02FT064.mail.protection.outlook.com (10.13.60.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 13:48:00 +0000
Received: from SGKCWEXCAPTT02.aztst.net (156.71.153.172) by
 SESKWEXCAPTT02.aztst.net (157.96.18.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jul 2023 15:47:44 +0200
Received: from SGKCWEXCAPTT01.aztst.net (156.71.153.171) by
 SGKCWEXCAPTT02.aztst.net (156.71.153.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jul 2023 21:47:04 +0800
Received: from [45.90.222.39] (156.71.153.243) by SGKCWEXCAPTT01.aztst.net
 (156.71.153.171) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 13 Jul 2023 21:46:59 +0800
MIME-Version: 1.0
Subject: For Your Urgent Processing
To:     Recipients <mrnathanielch5@gmail.com>
From:   Payment Dest information <mrnathanielch5@gmail.com>
Date:   Thu, 13 Jul 2023 06:46:52 -0700
Reply-To: <PaymentDesk@pinnaclebcorponline.com>
Message-ID: <6e1b12cd-0b4f-4211-a5a7-b4ad8dc12483@SGKCWEXCAPTT01.aztst.net>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR02FT064:EE_|AM8PR06MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 514b62f8-5834-4fdb-7b28-08db83a7c61a
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?KCgmsyidoIxdaCC2MOLZJSx+pIUGSzUSF44OnmmnW7j5Xwwsq8cwx0Rfb+?=
 =?iso-8859-1?Q?+m8mku7ZkV4mO8jcU36+BW9I24/Xk0CLLnR3Lf77tdUy6kISaIgKqWwvSD?=
 =?iso-8859-1?Q?F3RKUv+pxPRPo5fUTLc1GvXt4LUyN1KaXA0fOgrG3qO+UGcet6MVZ/3IYw?=
 =?iso-8859-1?Q?lQY8NMn8Lo2oRNXQNpYo+yq5RdUVI/YXXr+qGIWZjuqUs1RuNTnFQlFYbQ?=
 =?iso-8859-1?Q?1c5+okMsJXCzT616SHrhc+XEfaNBK8S/1ilMFFKvlTmNqFc6N9qVGNa2og?=
 =?iso-8859-1?Q?HeHszoK5cMKqCY1ofVOXvZxA54pTjMcQIabdGyY4RlHPPljg6jbJR5NFDK?=
 =?iso-8859-1?Q?/V8MwPwO/jEcwY68q/b1hrXrglZGa62KDLESW9vMEr+78JwrDeLg3hvMG1?=
 =?iso-8859-1?Q?OnuM5hd0nI2pOB1xE8atimQ+pIf4TttkJR9OWlGIFSnMRUgsnFkXF1dyqn?=
 =?iso-8859-1?Q?s5qMYOITREEzRAEc70ZrAmQgVGIRxkqeMHvL9e2x+9wR/slcFtwBM2y5on?=
 =?iso-8859-1?Q?N9yhMBgwIq+yPZhj5II23uJxMjLlR+KFyU0+kEuv0EYI6jc5DGpvHHqPVf?=
 =?iso-8859-1?Q?9Snh4/b+rEmWQ9P+U4s+tYamwQHT5K/WG01B2t5ULTd2ernU6EfEWqmBI4?=
 =?iso-8859-1?Q?ZbEInoV6M3CNMOqP0tinhrO5ZoOluNPDcySCfGHKBTYkdSO4jAqibR0Pgn?=
 =?iso-8859-1?Q?7guRWIANf5Vw1tcWz9c8YizSEKTgJWWnsPut9zoNauTXgegrB+vGc5eSaz?=
 =?iso-8859-1?Q?4ZPqsitLeLyhhyaro9FEoRHqp5XyxbI97pS3KCX13hD4HV3tGq15Xo0cQH?=
 =?iso-8859-1?Q?P6jPZLAqUqAny/YjBRiuXV8OxvAgeEWnwyW6/nWm3tVAH+yp+b32VZTmtZ?=
 =?iso-8859-1?Q?1eizVQnM9ka/ipJrsXhyMfbdX3VLjUnjTxvdk4VIvOyb+7k2Lb4VXncx9L?=
 =?iso-8859-1?Q?B4dtZmkvNY9YvXieb0bcGxHBSgXf+x+IwzeCHjxvi3OxBSRZctMTCujIOt?=
 =?iso-8859-1?Q?6fDYN4JUkYrmCe5r8UZV5BCBaQe2G9jLkasl35z6UmhJu2NZngn01mnrkD?=
 =?iso-8859-1?Q?a+/HtpqIJQx8LiA2nkLhJCY45Tb8u+FL6cQeW0/fPpy1bYJplLO35XQytG?=
 =?iso-8859-1?Q?zSlbQk9C09g3PAw4OEwc3zYY2qz5nT0wvFBDtO19VTGS49t8ZgkG6j9IX8?=
 =?iso-8859-1?Q?kz2G3/cWYcCyUQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:194.34.82.153;CTRY:SE;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:astrazenecatst.com;PTR:InfoDomainNonexistent;CAT:OSPM;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(84050400002)(451199021)(40470700004)(46966006)(40460700003)(6200100001)(6666004)(35950700001)(558084003)(83380400001)(47076005)(3480700007)(4743002)(73392003)(336012)(956004)(81166007)(82310400005)(356005)(31696002)(86362001)(82960400001)(82740400003)(26005)(82202003)(9686003)(40480700001)(70586007)(70206006)(6706004)(7416002)(4300700001)(16576012)(41300700001)(31686004)(5660300002)(6862004)(8936002)(316002)(8676002)(2906002)(508600001)(76482006)(62346015);DIR:OUT;SFP:1501
X-OriginatorOrg: AZCollaborationTST.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 13:48:00.8364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 514b62f8-5834-4fdb-7b28-08db83a7c61a
X-MS-Exchange-CrossTenant-Id: 018bdb4e-8280-4a61-a267-c21b54eb9f58
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=018bdb4e-8280-4a61-a267-c21b54eb9f58;Ip=[194.34.82.153];Helo=[astrazenecatst.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7602
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_50,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_FAIL,
        SPF_HELO_NONE,TO_EQ_FM_DOM_SPF_FAIL,TO_EQ_FM_SPF_FAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attn:Sir/Ma

Further to our earlier information, we wish to remind you of the urgent need to reconfirm your payment account receiving details for the payment of your full contract sum.
We look forward to an early reply.
Yours Faithfully,

Daniel Kiv.

