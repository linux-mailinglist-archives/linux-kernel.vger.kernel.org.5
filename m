Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2101E807C96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441810AbjLFXye convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 18:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjLFXyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:54:32 -0500
Received: from lhr.gtn-esa2.in (gtnesa2.ptcl.net [59.103.87.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B9BD1A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:54:34 -0800 (PST)
Message-Id: <573856$1hqc7q@lhr.gtn-esa2.in>
X-IPAS-Result: =?us-ascii?q?A2FbFgDhCHFl/0+gtbZagQkJgUhnaAKIEYgfoH6GR4F9D?=
 =?us-ascii?q?wEBAQEBAQEBAR0THQQBAYUGhy0nPAINAQIEAQEBAQMCAwEBAQEBAQMBAQEFA?=
 =?us-ascii?q?QEBAQEBBgMBAQECgRmFL0aCP4QOJzocKA0CJgJJFoVyryeBMhpnhF+xTiwDA?=
 =?us-ascii?q?YgMAYFQhAiUIBWCUwSffQcCBXBHcBsDBwN/DysHBC0iBgkULSMGUQQoIQkTE?=
 =?us-ascii?q?j4EMDuCRAqBAj8PDhGCPSs2NhlIglsVDDRKdRBCF4ERbhsTHjcREhcNAwh0H?=
 =?us-ascii?q?QIyPAMFAwQzChINCyEFVgNFBkkLAwIaBQMDBIEzBQ0eAhAsJwMDEkkCEBQDO?=
 =?us-ascii?q?wMDBgMLMQMwgRkMTwNrHzYJPA8MHwI5DScjAixWBRICFgMkGjYRCQsYEAMvB?=
 =?us-ascii?q?jsCEwwGBgleJhYCBwQnAwgEA18DDwMzER03CQN4PTUIDBtECEcdEqYZgkeWM?=
 =?us-ascii?q?owBgWugTgcDqVYBk14DhBqOHId/kEMgpHaFU4FohChRGaItgSQCBwsBAQMJi?=
 =?us-ascii?q?SKBQAEB?=
IronPort-PHdr: A9a23:YeDiexYfpm9IhXSXejqkBef/LTFq1oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1g+PBNWCoKsfw8Pt8IneGkU4oqy9+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS+bL9oM
 Rm7rhjdusYLjYZsN6081gbHrnxUdutZwm9lOUidkxHg6Mmu4ZVt6T5Qu/Uv985BVaX1YaE1R
 qFGATolLm44+tTluQHMQgWT6HQcVH4WkgdTDAje8B76RJbxvTDkued7xSKXINf5TbEwWTSl8
 qdrVBrlgzoJOjIl7G3ajNF7g6VHrR+vuxBz3pfYbJ2IOPFjeq/RYNMXSW9HU81MVSJOH5m8Y
 pMTAOUOMuhWspfzqVsQoBWwHwmhH//vyiZUinPqwaE2z+YsHAfb1wIgBdIOt3HUoc37OKkPS
 ++1ybPEwCnNY/5RxTr98onIch47rf+JXbJ/a8zRxFI3FwPZklqQrZbpPzWL2eQRqWSb9+lgW
 PuphmU6pA5/viKhyd0wionVmI0V0FbE+D14zYsxJdO2R092b9C4HJZSuC+XNYR7T8wjTmxmu
 Cg21qMLtYOmcCQX1ZgqyAPTZv+IfoaI/B/uW+ifLzlliX94fr+0mhW88VC4x+HhVcS4zkxGo
 jdGn9XRrHwByh3e5tSdRvZ/+kqs3yuE2R3L6u5eJEA6lrLbJoY8zrMziJYfq1nPEyzrlEnsk
 aObd1ko9vKq5unjZLjtu4KSN5duhQH7LqkuntS/AeQiPQYTQmiU4ua826P/8k3lWLhFlPM3n
 bPYsJDGJMQboKG5Ag9S0oY+8Ra/FSmp0M8AnXkAKlJFYwyIgo70MFzQJPD4EOy/g0iynzdx2
 v7GP7zgDYvVI3XBkLrsebBw4FNGxgUp19BQ/ZdUB6kEIPL0R0D+qsTVDgQ8Mwyo2+bnD8h91
 p8GVWKPHKCZNKTSvEeW6OwyOeWMfJUauDDkJ/g9/fHhkX45mVEcfaa1x5cYdHe4HvF8L0WFb
 3vgmtYBEWEUsQoiVOHmlV6PXSBJa3qvXK8w+ys3BJ+nAIvfXIyggriM0D++HpJMZ2BGDl6ME
 W3vd4WBQ/oBdDiSIs5vkjAeULahS5Uu1Re1uQ/i17poMu7U9jcetZ39yNh5/fXTlRIq+TxyF
 MuSy3uNQH1snmMUWz8227hyrVF5x1uby6h3n+RYFcBP5/NOSgo6NYTTzux+C9/sWgPNZNeJS
 EugQtWpGjw+UM4+z8UBY0lhAdmtkgrM0zKwA7AJj7yLGIA08qXE0njqOsZ9027G1K47j1k6W
 cZALnOphrZl9wfNHI7JiF+VmLqtdaQZxCLN7nuMzXKSvEFEVw59SbjKUmwGakvXq9T56ETCQ
 qSwBrQjKQtO19CCKqpUZd3zl1lJWPDjONHGb2Krh2iwHQqIxq+LbIfyZ2oSxiLdCUgZkw8N4
 HqKKRMzBiiko23EDTxuEUjjbF/r8el7sH+7VFM7zxmWb0190Lq44hoVhf2BS/wI37IEvjshq
 zVvHFamxN/WBN+AqBBgfKVYe98y/FBH1WeK/zB6a9a8aaVrnEMPegF+l0Wr0gl6AcNLlo4ot
 DlimCNoKKze81NIcRuAwZv0fLvaNi/q/0b8UaPO3kDi14OJ+6ML6f09sAyy4lmBHVIktXR7g
 PdP1H7JrK7DCUw7G8bYSEc5sTt6rrfyejU248XS2GEqKari4WyK4M4gGOZwkkXoRNxYKq7RT
 VKaLg==
IronPort-Data: A9a23:nUlAQa/HRFVYsPNmCFkfDrUDJ36TJUtcMsCJ2f8bNWPcYEJGY0x3z
 GobWmrXOP3eZGPxLop/PoW38U8FusKHmN5gQQRlqioxFiIbosfsO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFmF51XqPp8Zj2tQz2ILhXVvW0
 T/Pi5S31GGNimYc3l08tvrrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOhKmVgJdNWc
 s6YpF2PEsE1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXee0v0XRYRQR4/ttmHozx+4
 OpDlbfgUQoIBajjudVADEF+PCciO4QTrdcrIVDn2SCS53H9NWPlxbB2BUo3M4wTvO1wBCdS6
 pT0KhhUPkrF3rLvhuvlEq8z16zPL+GyVG8bklh6zD+fLvYvR7jbX67Oo9lVwHEohaiiGN6DP
 ZBFNWU2MnwsZTVEM2lMCoNipNuam1jDchx9pXyL/qAetj27IAtZleKF3MDuUtyDVMFYjwCYu
 2TJ12nyRB4RcteWoRKe72q0gfXTtSn2QJgfD6b+/flv6HWfzSkSDhMRfVa/uvSni0OkHdlYL
 iQ88SMpvLU/rRSDQdz0Xhn+q3mB1jYYWsdaEusm6BqW4qXR6gedQGMDS1ZpZNUiuYk2SDowx
 3eTmMj2CDhrqLSPSjSa7Lj8hTqpOSwYPCkZYygbQQYDy8Pku54+ihbXR8xgVqmvgbXdFTj2w
 j2OqCV4ibEejNUA16Cy+1bvmTW3uZXNShY8/AaRWXiqhitlbYugdsqj7VXS9+doNoGCUVSFu
 GANgcvY6/oBZbmPnSeOW+ILWq2g9vKCKhXGhkVwEp0l7z23+DikZ484yC1+KV1kKctCeiLzf
 F37owRK+5JXOGOjd6wxZJi+Y+wjyaXwHNLpTPmSddNIbpVrbyed+zpxaEqUx2n3kw4ri65XE
 YySa8/qFncRDqJgyDS3b/0ayqAmwiQmzHnQA5fhwHyP0rOfeHqUT/EOMFqCY/sl4bmsugLO7
 NtbM9OD0RYZV/fxCgHc+JUIJFYGN3F9B5n9qNdQcMaZJRF5FWUlE/bLwvUmYYMNt61OluPF7
 ze+W0lX4ED4nmLKLQGSY2pgLrT1Uv5Xr3MyOyktOxCtiyZ8SZem7KAYMZAweNEP8fZhzPdyQ
 PsEcsOFA/IWF2Tv9DEUbJ27p4tnHDymiQOSODCNezM+cphrSgDA+9v1OADo8UEz4jGf7Jtk5
 eTwj0WCH8JFGFUK4NvqVc9DBmiZ5RA18N+elWOSSjWPUC0AO7SG58A8YjHb7i3Mxdj+KuOm6
 jur
IronPort-HdrOrdr: A9a23:ZFFWH6MxoAr8SMBcTtGjsMiBIKoaSvp037Dk7SBModU8SKClfq
 eV8cjztCWetN9/YgBCpTntAsi9qBDnn6KdiLN5VYtKOjOW2ldAR7sM0WKN+VPdJxE=
X-Talos-CUID: =?us-ascii?q?9a23=3ArjfGlmsGQBZ4oUR0+BDQw5Pq6IsafF32nG/dAnS?=
 =?us-ascii?q?9JkdYFeLNb3CWpKVNxp8=3D?=
X-Talos-MUID: 9a23:1TvOdAp3N4Y3yEwsBQIezzprCpxq8viWNHIQsKkHmuyJGzIrMR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,256,1695668400"; 
   d="scan'208";a="52244730"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO TS.pan-pacific.com.tw) ([182.181.160.79])
  by lhr.gtn-esa2.in with ESMTP; 07 Dec 2023 04:54:24 +0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: #Awaiting your response
To:     "t.maruyama@n-mtec.co.jp" <Arif.Khan@ptcl.net.pk>
From:   "Sam.A" <Arif.Khan@ptcl.net.pk>
Cc:     asghar.meo@ptcl.net.pk
Date:   Thu, 07 Dec 2023 07:54:16 +0800
Reply-To: williams1960@cpn.it
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,FROM_MISSPACED,
        FROM_MISSP_EH_MATCH,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RCVD_IN_PSBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [59.103.87.20 listed in list.dnswl.org]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [59.103.87.20 listed in psbl.surriel.com]
        *  0.0 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [59.103.87.20 listed in bl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
        *  0.0 MSGID_FROM_MTA_HEADER Message-Id was added by a relay
        *  1.7 FROM_MISSPACED From: missing whitespace
        *  2.0 FROM_MISSP_EH_MATCH From misspaced, matches envelope
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H e l l o,

I'm a consultant, I work with a client who is interested in entering into a joint venture corporation in your nation. He has capitals set aside for this purpose.

Kindly get in touch with me if you're interested.

Regards,
Mr. Sam A. Williams
