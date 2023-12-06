Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3113807953
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442902AbjLFUXQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 15:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379537AbjLFUXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:23:15 -0500
Received: from lhr.gtn-esa2.in (gtnesa2.ptcl.net [59.103.87.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A941BD67;
        Wed,  6 Dec 2023 12:23:15 -0800 (PST)
Message-Id: <573856$1hna7i@lhr.gtn-esa2.in>
X-IPAS-Result: =?us-ascii?q?A2EsDAAb13Bl/0+gtbZaHQEBAQEJARIBBQUBQAmBRgKFD?=
 =?us-ascii?q?4RTqR2GRxOBag8BAQEBAQEBAQFNBAEBhQaHLSc6BA0BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBAQUBAQEBAQEGAwECAoEZhS9Ghk0nVigNAhkNAkkWE4VfrzKBMhpnh?=
 =?us-ascii?q?F+xTi4Bgm6FHwGBUIQIkBABEgGDfBWCUwSJFwcyhUopiTuGegcCBXBHcBsDB?=
 =?us-ascii?q?wN/DysHBC0iBgkULSMGUQQoIQkTEj4Ea4JECoECPw8OEYI9YTYZSIJbFQw0S?=
 =?us-ascii?q?nUQQheBEW4bEx43ERIXDQMIdB0CMjwDBQMEMwoSDQshBVYDRQZJCwMCGgUDA?=
 =?us-ascii?q?wSBMwUNHgIQLCcDAxJJAhAUAzsDAwYDCzEDMIEZDE8Dax82CTwPDB8COQ0nI?=
 =?us-ascii?q?wIsVgUSAhYDJBo2EQkLKAMvBjsCEwwGBgleJhYJBCcDCAQDWgMKAzMRHTcJA?=
 =?us-ascii?q?3g9NQgMG0QIRx0SozR4AYFHRIEQIYVCjXaDaIoeg06gTgeOEptHAZNeA5I2R?=
 =?us-ascii?q?4c4hGqLWSCqNQ1/cIQnUhmiLWk7AgcLAQEDCYpiAQE?=
IronPort-Data: A9a23:ZCV6d6yPJ5UtLqm+NON6t+cUxirEfRIJ4+MujC+fZmUNrF6WrkUOz
 WIbWmvVOquMYTOhctkiOYq3ox8G6pCHyYNiTldqrS00HyNBpOP7XtnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9T8mvU2xbuKU5NTsY0idfic6Dn994f5fs7Rh2NUx24DnW1jlV
 e7a+qUzBnf0g1aYDUpJs8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByKQrr1vIwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Zz
 4UKrZyPbh4VJYrngv0SVBhWPyAlBPgTkFPHCSDXXc2783aAa3Lqhu1nB0A4PIZe8eFyR31Rn
 RAaAGldNFba17vwmezjDLY97iggBJCD0Ic3k2thw3f6Df8gaYjfSKGM49JEmi8z7ixLNauEP
 pZFMmQ/BPjGSw92OXYKT6tipduH13bxayVAqnK+/6VitgA/yyQ0itABKuH9Zd2MbcBYkU/do
 G/c8yLyBRRyHN2Zxz2t+XKhj/fOhia9U4UXfJWx8vN6iVufy3ZVBAAHXliTrvywi0r4UNVaQ
 2QZ9jcrpLo/6GSkSd7yWxD+q3mB1jYVS9BXHsU55RuLx66S7wXxLncFSjpQQN0gutU/STEj2
 hmOhdyBLT5osLvTR3uG6r6eoDW+EScQJG4GIyQDSGMt4dDgvYsbhRbIU9ptFKevg5v+HjSY6
 zmOrSIji7w7ic8NyrX99FTGiTumr97CSQtdzg/QRGO+9it/eo+pZoXu4l/ehd5bMIuXQFSH+
 nsAktOF4foSJYqAnzGLTflLF7asj96FPSfWjERzN5Ym8Tiq4TiqZYlW6Xd5PkgvO9tsUTXxb
 mfNtg5LopxeJn2naelweY3ZI8Ary7XwUM++B6j8cNVDeN5yeRWB8SUoYlSft0jxl00Ejag7I
 ZqKN82rCB4yAql/zH+6SvkQ1Zc1yS0kg2DeX5b2y1Kgy7X2TH6eSZ8BK0fIYu1RxKCPoC3T7
 ddTNsLMwBJaOMX8ZiPa+qYeM1EONXwyA9bxscM/SwKYClM2Qid4W6aXmO15PdM090hIqtr1E
 riGchcw4DLCabfvcG1mtlgLhHjTsVqTYJ710eHA/bpl5pT7XbuS0Q==
IronPort-HdrOrdr: A9a23:v/FZg6kPrsOTn8g0s545BVQqauzpDfI83DAbv31ZSRFFG/FwWf
 rPoBzTvSWZtN93YhwdcLG7U5VoLkmslqKdjbNxAV7AZmPbUQKTRelfBO3Zsl/d8kbFmdK1u5
 0PT5RD
X-Talos-CUID: 9a23:860YcG434+76J252z9ss8x5TAsAaVWTh11D7OVa3DmdnZLzOcArF
X-Talos-MUID: 9a23:oN9O5QRQpbTFJYc7RXT+vTJDKYBRv52SJxECn40eo8ukHnZ/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,256,1695668400"; 
   d="scan'208";a="52144370"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO TS.pan-pacific.com.tw) ([182.181.160.79])
  by lhr.gtn-esa2.in with ESMTP; 07 Dec 2023 01:22:51 +0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: #Congrat!!
To:     "t.maruyama@n-mtec.co.jp" <Arif.Khan@ptcl.net.pk>
From:   <Arif.Khan@ptcl.net.pk>
Cc:     asghar.meo@ptcl.net.pk
Date:   Thu, 07 Dec 2023 04:22:32 +0800
Reply-To: grantsprogram@cpn.it
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,LOTS_OF_MONEY,
        MONEY_NOHTML,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RCVD_IN_PSBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [59.103.87.20 listed in bl.mailspike.net]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [59.103.87.20 listed in list.dnswl.org]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [59.103.87.20 listed in psbl.surriel.com]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
        *  0.0 MSGID_FROM_MTA_HEADER Message-Id was added by a relay
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 MONEY_NOHTML Lots of money in plain text
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Congrat!!

Ref No: BEH/XGM/012/0023.

Your email address was chosen at random during an internet search to receive USD 805,000.00 from me, the chairman and CEO of Berkshire Hathaway. If you are interested respond promptly via this e-mail:{grantsprogram@cpn.it} to learn more about the donation and how to claim it.

Regards,
Warren Edward Buffett
