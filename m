Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861F77B5E79
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 03:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbjJCBN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJCBNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:13:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF4ABD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=s9FX2e7HB0C/C0j0BGnkZfrxNTyqijAWhZcdpk9I1hs=; b=dRKdxw2tXlQSJgspk5omjZXVtm
        AFQRbxFP+oANivIn/iNSJdtv4YarYlsXNDQT0Bo1f+kveT+QJ66ziOKCjH9b5wQyyMCA4RsDD8e9a
        uDFhO86yy4OQ6geKor/03yBKXetLU2MIiuAfu+DY+Ks+2MrDG2RumBX1fynAZgY30IG9NEG+5BnT8
        dSLFoTvsVLYxrV1UTJg0m5/mmlNThm/ecoEJrRBDJI2GwO16cQ2nqyk5chmwymGkNTviw6mBPTaaj
        3Vw1Pn4vqN4C9YBEfa0O5tF9543nsVLO4DgP0HCFegZKiOv5W2oC7oTAdeQc8yAXpWC6DnvEzXPYW
        s0TZ5mEQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qnTyx-00DcHx-0d;
        Tue, 03 Oct 2023 01:13:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/3] drm/fourcc: fix doc typos
Date:   Mon,  2 Oct 2023 18:13:48 -0700
Message-ID: <20231003011349.27593-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003011349.27593-1-rdunlap@infradead.org>
References: <20231003011349.27593-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling and remove an extraneous word.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/uapi/drm/drm_fourcc.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff -- a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -54,7 +54,7 @@ extern "C" {
  * Format modifiers may change any property of the buffer, including the number
  * of planes and/or the required allocation size. Format modifiers are
  * vendor-namespaced, and as such the relationship between a fourcc code and a
- * modifier is specific to the modifer being used. For example, some modifiers
+ * modifier is specific to the modifier being used. For example, some modifiers
  * may preserve meaning - such as number of planes - from the fourcc code,
  * whereas others may not.
  *
@@ -79,7 +79,7 @@ extern "C" {
  *   format.
  * - Higher-level programs interfacing with KMS/GBM/EGL/Vulkan/etc: these users
  *   see modifiers as opaque tokens they can check for equality and intersect.
- *   These users musn't need to know to reason about the modifier value
+ *   These users mustn't need to know to reason about the modifier value
  *   (i.e. they are not expected to extract information out of the modifier).
  *
  * Vendors should document their modifier usage in as much detail as
@@ -538,7 +538,7 @@ extern "C" {
  * This is a tiled layout using 4Kb tiles in row-major layout.
  * Within the tile pixels are laid out in 16 256 byte units / sub-tiles which
  * are arranged in four groups (two wide, two high) with column-major layout.
- * Each group therefore consits out of four 256 byte units, which are also laid
+ * Each group therefore consists of four 256 byte units, which are also laid
  * out as 2x2 column-major.
  * 256 byte units are made out of four 64 byte blocks of pixels, producing
  * either a square block or a 2:1 unit.
@@ -1101,7 +1101,7 @@ drm_fourcc_canonicalize_nvidia_format_mo
  */
 
 /*
- * The top 4 bits (out of the 56 bits alloted for specifying vendor specific
+ * The top 4 bits (out of the 56 bits allotted for specifying vendor specific
  * modifiers) denote the category for modifiers. Currently we have three
  * categories of modifiers ie AFBC, MISC and AFRC. We can have a maximum of
  * sixteen different categories.
@@ -1356,7 +1356,7 @@ drm_fourcc_canonicalize_nvidia_format_mo
  * It considerably reduces memory bandwidth while writing and reading
  * frames in memory.
  *
- * The underlying storage is considered to be 3 components, 8bit or 10-bit
+ * The underlying storage is considered to be 3 components, 8-bit or 10-bit
  * per component YCbCr 420, single plane :
  * - DRM_FORMAT_YUV420_8BIT
  * - DRM_FORMAT_YUV420_10BIT
@@ -1417,7 +1417,7 @@ drm_fourcc_canonicalize_nvidia_format_mo
  * Amlogic FBC Memory Saving mode
  *
  * Indicates the storage is packed when pixel size is multiple of word
- * boudaries, i.e. 8bit should be stored in this mode to save allocation
+ * boundaries, i.e. 8-bit should be stored in this mode to save allocation
  * memory.
  *
  * This mode reduces body layout to 3072 bytes per 64x32 superblock with
