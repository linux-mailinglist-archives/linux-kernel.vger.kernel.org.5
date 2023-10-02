Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132A07B4A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 03:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjJBBIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 21:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjJBBIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 21:08:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9FBAB
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 18:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nngXHStwMm/8b0PbSb+Shl8IOlqNc+wbIGR/pgQDPss=; b=jUpy1oUFYb3ixmnJNKrsMC2mF5
        7JStuKpGRv8QxLzzJacggxsNEa6nAPE7waV7RfwPHmjLD3BaUzdM0HKuf3xuhPF5ATReaxgIjvsD1
        m0oulql6TxwYvkuMtveo99BCx9XLRFDWAziYHtM0XGe7y6672I8CN1r21RqcuCbxEIbt7VxTWy8cs
        CNRvhJ0wIJDmmKRsaXgnAOTIikZX8kuo+tknjoeRDO0mWwg9yo+nWdjoPMNVUD1YfmrSUKrR13z9k
        S6YhU7xsok4JW+VZe1nePdONZHhP7isykb9GNKBVEo7PArTn3QgAjDoOM7RCEqt8mPO2s+668jmQF
        RA8Rcyew==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qn7QJ-00Bmzj-34;
        Mon, 02 Oct 2023 01:08:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: amdgpu_drm.h: fix comment typos
Date:   Sun,  1 Oct 2023 18:08:33 -0700
Message-ID: <20231002010835.14798-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct typos of "occurred".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 include/uapi/drm/amdgpu_drm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -249,9 +249,9 @@ union drm_amdgpu_bo_list {
 /* unknown cause */
 #define AMDGPU_CTX_UNKNOWN_RESET	3
 
-/* indicate gpu reset occured after ctx created */
+/* indicate gpu reset occurred after ctx created */
 #define AMDGPU_CTX_QUERY2_FLAGS_RESET    (1<<0)
-/* indicate vram lost occured after ctx created */
+/* indicate vram lost occurred after ctx created */
 #define AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST (1<<1)
 /* indicate some job from this context once cause gpu hang */
 #define AMDGPU_CTX_QUERY2_FLAGS_GUILTY   (1<<2)
