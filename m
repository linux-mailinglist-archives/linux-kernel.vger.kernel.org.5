Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CABD7B4460
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 00:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjI3WOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 18:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjI3WOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 18:14:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A5D3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Qv7sIj+M0crhVSc6FpMOVlK8L6+Jn5DSpcnSw/+/oEM=; b=WMJNfUGBRsbOUDLvFPbNhvF0Ee
        zPdk79w3ON2Kn2CdrvQBvtec+tdxCvHCd9A8H15e7VTRUQq3ibrYtAiS+XnpsLT7j982TpSt5xp2u
        Jb2PokZJ/xyNshqAEEFcCGaQi5NKsYDpGD7L3ABxiw5ATO0HeyBey0dz+YnL4ZxCNRwQMMHcdMDKQ
        0HTHiBvTR1G/0WF/uosutnucQNyP2gOxSUJhG9Rw4o3Y4ma/qtxCOLOdAKbTXEUd2IDeMS0LWr/zC
        uZ2OWNjSBsxHB3MDy0f+H8MJtL32ToXmBq4YWNgqA1c0Xxx5ucjMNT6/zBPs30dYHEubV7GjY1g2W
        RGkXhhMg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmiEH-00AAxS-2j;
        Sat, 30 Sep 2023 22:14:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] iosys-map: fix kernel-doc typos
Date:   Sat, 30 Sep 2023 15:14:27 -0700
Message-ID: <20230930221428.18463-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230930221428.18463-1-rdunlap@infradead.org>
References: <20230930221428.18463-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling of "beginning".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
---
 include/linux/iosys-map.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/linux/iosys-map.h b/include/linux/iosys-map.h
--- a/include/linux/iosys-map.h
+++ b/include/linux/iosys-map.h
@@ -426,7 +426,7 @@ static inline void iosys_map_memset(stru
  * iosys_map_rd_field - Read a member from a struct in the iosys_map
  *
  * @map__:		The iosys_map structure
- * @struct_offset__:	Offset from the beggining of the map, where the struct
+ * @struct_offset__:	Offset from the beginning of the map, where the struct
  *			is located
  * @struct_type__:	The struct describing the layout of the mapping
  * @field__:		Member of the struct to read
@@ -494,7 +494,7 @@ static inline void iosys_map_memset(stru
  * iosys_map_wr_field - Write to a member of a struct in the iosys_map
  *
  * @map__:		The iosys_map structure
- * @struct_offset__:	Offset from the beggining of the map, where the struct
+ * @struct_offset__:	Offset from the beginning of the map, where the struct
  *			is located
  * @struct_type__:	The struct describing the layout of the mapping
  * @field__:		Member of the struct to read
