Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C118085FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjLGJ7D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 04:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjLGJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:59:01 -0500
Received: from lhr.gtn-esa2.in (gtnesa2.ptcl.net [59.103.87.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E91D2A8;
        Thu,  7 Dec 2023 01:59:03 -0800 (PST)
Message-Id: <573856$1i4eng@lhr.gtn-esa2.in>
X-IPAS-Result: =?us-ascii?q?A2GgFwAglnFl/0+gtbZagQkJgUhnaAKIEYgfoH6GR4F9D?=
 =?us-ascii?q?wEBAQEBAQEBAR0THQQBAYUGhy0nPAINAQIEAQEBAQMCAwEBAQEBAQMBAQEFA?=
 =?us-ascii?q?QEBAQEBBgMBAQECgRmFL0aCP4QOJzocKA0CJgJJFoVyrxGBMhpnhF+xTiwDA?=
 =?us-ascii?q?YgMAYFQhAiUIBWCUwSgAgcCBXBHcBsDBwN/DysHBC0iBgkULSMGUQQoIQkTE?=
 =?us-ascii?q?j4EMDuCRAqBAj8PDhGCPSs2NhlIglsVDDRKdRBCF4ERbhsTHjcREhcNAwh0H?=
 =?us-ascii?q?QIyPAMFAwQzChINCyEFVgNFBkkLAwIaBQMDBIEzBQ0eAhAsJwMDEkkCEBQDO?=
 =?us-ascii?q?wMDBgMLMQMwgRkMTwNrHzYJPA8MHwI5DScjAixWBRICFgMkGjYRCQsYEAMvB?=
 =?us-ascii?q?jsCEwwGBgleJhYCBwQnAwgEA18DEQMzER03CQN4PTUIDBtECEcdEqYcgkeWM?=
 =?us-ascii?q?owBgWugTgcDqVYBk14DhBqOHId/kEMgpHaFU4FohChRGaItgSQCBwsBAQMJi?=
 =?us-ascii?q?SKBQAEB?=
IronPort-PHdr: A9a23:eKS0fhdvGS/X0KelGHQjdTbalGM+ctjLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWZG9yLsbkc1KL/iOPJZy8p2dW7jDg6aptCVhsI2409vjcLJ4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTajYr5+N
 gi6oAbPusUZnYdvKLs6xwfUrHdPZ+lZymRkKE6JkRr7+sm+4oNo/T5Ku/Im+c5AUKH6cLo9Q
 LdFEjkoMH076dPyuxXbQgSB+nUTUmMNkhpVGAfF9w31Xo3wsiThqOVw3jSRMNDsQrA1XTSi6
 LprSAPthSwaOTM17H3bh8pth61cvB+sqQBzz5PNbI2JKfZ1Y6fRcc4aSGZEWMtaSi5PDZ6mb
 4YXE+UOMulWoZTjqVUOsxawCxOsCfjzyj9RmnP6wbE23/gjHAzAwQcuH8gOsHPRrNjtOqscT
 Pq6zKzSwTjfYf9b3ivw6JLJchAvu/2CWLJwftDXyUQ0DwPFkkmfqYj/MzOTyOsNr3KX7/JjV
 e+2jWMstg5+rCS1yMg2lonJmpwaykrC9ShhwYs4Id22RkF6bNCqDJddtS6UOol5T84tQmxlt
 iY0xqEYtJKmYSQG1YkryhHCZ/GEfIWG4gzuWemfLzl2mX9oZbSyjAux/0i40uDwS8q53EhQo
 iZYkdTAq2oB2wHS58SbUPdw/EOs1DCS3A7O8uFLO0U0m6nDK5M537I9lYQfvV7eEiL1hUn6l
 rKae0Q49uSy6enqZrPrrYKBOoBulw7wLrohmtSiAeQkPAYOWG2b9v691L3l5UD5WKlKgeEyk
 qXDtpDVO9gbqrShAw9W1Iso9guxDy+839QdgXQHKEpFeBKdgIb0JlHBO/L4AumjjFSwiDpk3
 f7HMafgApXRL3jDlrjhfLZ6605B0goz185Q54lMCrEGJvLzQVH+udrFBRInNwy03v3nCMlj2
 YMERGyPA66YP73KvFOV5u8jPe+Bb5IPtjnnMfgq/fvugGc8mV8aYKamw4MaaGu9HvR6O0WZZ
 mfsgssZHWcKoAU+SOvqhUWcXzBOfXqyR7gz5jciBIK+F4jMWoGtgLKA3CinBJFZemdGClWWH
 Xf0eYSIQ/YMaCSMLc99ijEISLusR5E72R2ztwL21qBrIvfV9yEEr57u1tx46/XWlR4o9Dx0C
 8qd03uKT2Fxhm4FWyU23KFxoUBnz1mD0bJ3g/pDGNxL+/NGTgM6OYTaz+NkF9D+QBrBftSRR
 FagWdqpGSsxQc4pw98Sf0Z9HM2vgg3H0iayGb8ai6SLBIAo8qLbx3X+PcJ9y3jf2KY7jFkpX
 NFDNW+8ia557AjTHInJk0OCmqa2aKsTwCnN9GGYzWqTuEFYTA9wUaPKXX8FfUTat8j25kTHT
 7O2E7QoLhNBydKeKqtNctDpgkhGRPHiONTaZ2K+gX28BQ6WybOQcIrlZX8d3D7GCEgDlQAe5
 nOGNQkjBienuW7eFyJhGUr1Y0zw6el+tG+7Tkgswg6WaE1h0r+1+gMThfydV/wcxK4EuCYmq
 zVyB1awxMzZBMaOpwp7ZqlTf8497E9d1W3Frwx9IoCgL6d6i14cbQt3pFju1xRrBYpai8Qlt
 nUqwxdsJqKCy1NBbDSY3ZbrN73UMGn94gqgZLXM1l7C19aW/78D6O4kpFX7oAGpCk0i/m1j0
 9lUyHuT/I/GAxAUUZ3sTEk37QN6p6rdYik7/I7U0WBsMa+pvTPYwNImGrht9hH1NcsZNaqeC
 R77FsQyAY2rNOEh3VOuKBAcdqgG3bQ1MYWFd/KA8La3N+Immj+6y3xEttNH31qI5hZ7H/HJ2
 5IEyvSDh1rZDx/3lFHns9ykt5pDYGRYJWO6jwGuUKdLZ6M0XoYCD0+2P8azgNNzm9j1WCgLp
 xaYG1oa1ZrxKlKpZFvn0FgJiCwq
IronPort-Data: A9a23:+pM8PayDf4NB5whBRvB6t+cBxirEfRIJ4+MujC+fZmUNrF6WrkUAy
 WRLCGjUb/6DajakLdEladyxo0pSvsLdyYBkSgNrrC00HyNBpOP7XtnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9T8mvU2xbuKU5NTsY0idfic6Dn994f5fs7Rh2NUx24DmW1rlV
 e7a+qUzBnf0g1aYDUpJs8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByKQrr1vIwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Z1
 OxjtLWTQDUSAffKwuMeVwBqAxFkMvgTkFPHCSDXXc2783aAa3Lqhu1nB0A4PIZe8eFyR31Rn
 RAaAGldNFba17vwmezjDLY97iggBJCD0Ic3k2thw3f6Df8gaYjfSKGM49JEmi8z7ixLNauEO
 pVFOGcxBPjGSxtTHGkUIsIPp/yPi3zUdCJbo2jKg5NitgA/yyQ0itABKuH9c9iEAMxWkwCar
 2Td5GP/Kg0WP9uZ0ieB7nOqiebF2yj8Xeo6G6C+9/puiRuLy3APBQcNTly9ify4l0j4QN83A
 0cT/y8zq6k5/VCqSd/mdxCzrmTCswN0c9hdCPY74wjLw6zY7hyCHW8CZj1bZdUs8sQxQFQC0
 l6SlpXgAzBiqqaOTnS18qqSoXWpNEA9KGYYZCZCVQYZ4sXLpJw1glTUQ75LFK++jvXxBDf8h
 SuHxAAlgrUSpdUO16T95l2vqyihpYLUUhI4/ATRUXms9BlwYoGoYoGu9VXBxe1BKpqUQB+Hu
 xAsg8+F8OUJEY2El2qBQeoMALitz+2ENiHRjxhpGPEJ+jKg4XGyO5pd+zx3PkxpGt0FfyPkb
 gnVvmt55ZlfIWC2d65feIO3F8kki67nffziXf3daPJVY55teQHB+iYGTUuZ2X3jmUMwjLs+P
 5izaseqEXsUT6JgpBK3Qeka+aQqwDwzyyXVQvjT1w6mz7OVdVaOSLEZPVXIaOdRxKWD5R/Y6
 9JOH9CLzQlSXqv4ZUH/8IgdKngGI3s6Q5z7w+RcfeeKJiJqFmIgTfPcqY7NYKQ8z/4Tz7eRu
 CjjAgkHmTITmEH6FOlDUVg7AJuHYHq1hShT0fAEVbpj55TvjUtDIkvSm1vbsITLLNBe8MM=
IronPort-HdrOrdr: A9a23:g6VMD6n8Be2a9zeZ0WsOxUsjjD3pDfI83DAbv31ZSRFFG/FwWf
 rPoBzTvSWZtN93YhwdcLG7U5VoLkmslqKdjbNxAV7AZmPbUQKTRelfBO3Zsl/d8kbFmdK1u5
 0PT5RD
X-Talos-CUID: =?us-ascii?q?9a23=3AX/pcIWooXaPeJ8e+4m1NgvLmUdwcXHz0737iGHD?=
 =?us-ascii?q?iDzxuS7mMe0+g4qwxxg=3D=3D?=
X-Talos-MUID: 9a23:5qag6AZ6mbfM8OBTsSPKujJIZPZT+IOjDWsKjpYNgZaiDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,256,1695668400"; 
   d="scan'208";a="52574960"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO TS.pan-pacific.com.tw) ([182.181.160.79])
  by lhr.gtn-esa2.in with ESMTP; 07 Dec 2023 14:58:49 +0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: #Awaiting your response
To:     "t.maruyama@n-mtec.co.jp" <Arif.Khan@ptcl.net.pk>
From:   "Sam.A" <Arif.Khan@ptcl.net.pk>
Cc:     asghar.meo@ptcl.net.pk
Date:   Thu, 07 Dec 2023 17:58:21 +0800
Reply-To: williams1960@cpn.it
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,FROM_MISSPACED,
        FROM_MISSP_EH_MATCH,MSGID_FROM_MTA_HEADER,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L3,RCVD_IN_PSBL,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [59.103.87.20 listed in zen.spamhaus.org]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [59.103.87.20 listed in psbl.surriel.com]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [59.103.87.20 listed in bl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MSGID_FROM_MTA_HEADER Message-Id was added by a relay
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
        *  1.7 FROM_MISSPACED From: missing whitespace
        *  1.9 FROM_MISSP_EH_MATCH From misspaced, matches envelope
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
