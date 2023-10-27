Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5B87D911C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjJ0ITn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjJ0IT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:19:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A4D6D;
        Fri, 27 Oct 2023 01:19:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5hxH6009507;
        Fri, 27 Oct 2023 08:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=H0/aCDFt4Sn9FnJqoeRJjT/9P98mgpduCZMNdUkai2Y=;
 b=I7Ce0QoF9iOgsWGsFkpEFEK0eoPQ5t7jGHvB7iF+taEqlN3MBF+YjoRU4c566XShlm5X
 UGpCiadlLhbisUKbVy+VCFg3RM3+hU6Bwb6OOrVNQ/PaWxmsDVamsFuGODzjuUKsR7dj
 Dhi9q76uRw6DtcOlCxejffOkfF8ZHadykOLuUunQmi6O8VaJYBy/kfnpUsW3F5gbYPLT
 frkLxM+z2nKRfo5JHMUqJSHb2vfWJvQ+fTN5zF9unEcLbjbAUoKw257Zt9rZ6u6uD4ZT
 NE7uH4hAdp3b7/9GM5xgGGD+dq+sTNtXGAgZBNeh9VvhuMtIaDz6KiPEwTk9kD0tI+yS Hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx218x86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 08:19:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39R6Bkhp009253;
        Fri, 27 Oct 2023 08:19:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjebju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 08:19:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39R8Ig9f028975;
        Fri, 27 Oct 2023 08:19:14 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-63-126.vpn.oracle.com [10.175.63.126])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tywqjeb1g-12;
        Fri, 27 Oct 2023 08:19:13 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 11/11] docs: remove .toc-title class
Date:   Fri, 27 Oct 2023 10:18:30 +0200
Message-Id: <20231027081830.195056-12-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027081830.195056-1-vegard.nossum@oracle.com>
References: <20231027081830.195056-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_06,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270071
X-Proofpoint-ORIG-GUID: vJdNOq0fC4ie_LIk4NGSKgqQrgRerXJU
X-Proofpoint-GUID: vJdNOq0fC4ie_LIk4NGSKgqQrgRerXJU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "toc-title" class was introduced in commit ef88f10eb877
("[media] doc-rst: backward compatibility with older Sphinx versions")
as a workaround for Sphinx versions older than 1.4.x. However, these
old versions have been deprecated since commit 31abfdda6527
("docs: Deprecate use of Sphinx < 2.4.x").

Having now changed all the toc-title users to use the :caption:
attribute, we can also remove the custom style.

Note that the toc-title class is separate from the "kernel-toc"
logic that was introduced in commit c404f5d4f099 ("docs: Add more
information to the HTML sidebar").

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/sphinx-static/theme_overrides.css | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/sphinx-static/theme_overrides.css b/Documentation/sphinx-static/theme_overrides.css
index f6f2b941a5d6..79000b26e64e 100644
--- a/Documentation/sphinx-static/theme_overrides.css
+++ b/Documentation/sphinx-static/theme_overrides.css
@@ -81,11 +81,6 @@ div[class^="highlight"] pre {
      *   - hide the permalink symbol as long as link is not hovered
      */
 
-    .toc-title {
-        font-size: 150%;
-	font-weight: bold;
-    }
-
     caption, .wy-table caption, .rst-content table.field-list caption {
         font-size: 100%;
     }
-- 
2.34.1

