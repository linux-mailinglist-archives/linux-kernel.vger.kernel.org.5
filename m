Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3C76777F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjG1VQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjG1VQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:16:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E633C30;
        Fri, 28 Jul 2023 14:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39EF2621FF;
        Fri, 28 Jul 2023 21:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2D3C433CA;
        Fri, 28 Jul 2023 21:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690578981;
        bh=NsRxddDlLqahYaViS384MxGc/Qfc6oFDePNf6w+QqoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuJnstbUtkvCNp0Gra75/xOdXcaWKDCRTsYO+r99XiqpVJMvOk5JoSnrODw9gYXkQ
         YsssH2Tfc3A1NY8tPToUhRchUl7f1O7ZK2B/NZxmZKEScUI6fq2/fYDacML1YuVJPi
         gvLISQMOlUCyh1aRg5mZoqqySEtaUZPRRJn5qY9NpRVHpHZRORG0/rpCAqVjtCuOse
         VYYF02YAVdhnsDqivNZGsQHGZ+Xnww1AGd4xMzkzKK9YjIaht+FmJgjgdmDO6yuhao
         4ySUCN1mtWsGu+J6lxLZjbKPV2zB7XSdK3lSSjN0AMa+wiMMedQgQ5DZ5b8/PaNjb4
         Ofq7f3H3Lat5A==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj@kernel.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Docs/process/changes: Replace http:// with https://
Date:   Fri, 28 Jul 2023 21:16:16 +0000
Message-Id: <20230728211616.59550-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728211616.59550-1-sj@kernel.org>
References: <20230728211616.59550-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some links are still using 'http://'.  Replace those with 'https://'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/process/changes.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index f05eada0383e..1982fa896f3b 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -482,7 +482,7 @@ E2fsprogs
 JFSutils
 --------
 
-- <http://jfs.sourceforge.net/>
+- <https://jfs.sourceforge.net/>
 
 Reiserfsprogs
 -------------
@@ -503,7 +503,7 @@ Pcmciautils
 Quota-tools
 -----------
 
-- <http://sourceforge.net/projects/linuxquota/>
+- <https://sourceforge.net/projects/linuxquota/>
 
 
 Intel P6 microcode
@@ -524,7 +524,7 @@ FUSE
 mcelog
 ------
 
-- <http://www.mcelog.org/>
+- <https://www.mcelog.org/>
 
 cpio
 ----
@@ -544,8 +544,8 @@ PPP
 NFS-utils
 ---------
 
-- <http://sourceforge.net/project/showfiles.php?group_id=14>
-- <http://nfs.sourceforge.net/>
+- <https://sourceforge.net/project/showfiles.php?group_id=14>
+- <https://nfs.sourceforge.net/>
 
 Iptables
 --------
@@ -560,7 +560,7 @@ Ip-route2
 OProfile
 --------
 
-- <http://oprofile.sf.net/download/>
+- <https://oprofile.sf.net/download/>
 
 Kernel documentation
 ********************
-- 
2.25.1

