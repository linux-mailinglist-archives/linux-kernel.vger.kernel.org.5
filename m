Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517FA797A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245371AbjIGRkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245224AbjIGRjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:39:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FCABC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:39:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23823C4AF6A;
        Thu,  7 Sep 2023 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694097167;
        bh=LjOKbvV/82aSzI3htAHPz7uDv9ANVHELjK+4PnKTL/g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gKP9BeFsQt7ozkUWNv4n1BdlBM/7y3ZALc00V4LDGWwsmx7F82Axgp6ULm+bEvfg1
         ddzmCnh+C039DfFl3VLi7GD4EZQpfjqABJj7/GZSPTihl0nuUHRU31KdKfBRQNR1C4
         tUAxmQk+9tOwmtZT+nCERD4tPgSUjzrLzvxJ6ATDqggOSF+6r5Q4H/wp1HIz4iqhpo
         wKOZ8b1k6AHHMn0LJFh5J9zp82durlushh3KtncNhv6NsYSB0W9H25btgRZfUVnTaY
         6dD9r7q3U5KpMQz1Nxo8nkdzT5cxuLE5i8eQ4L7hk4YeLsMBVg1/u8HoDcY2M9rjO9
         QW57Z8X3VnZfw==
From:   Maxime Ripard <mripard@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230906-topic-drm_connector_doc-v2-1-1f2dcaa43269@gmail.com>
References: <20230906-topic-drm_connector_doc-v2-1-1f2dcaa43269@gmail.com>
Subject: Re: (subset) [PATCH v2] drm/connector: document
 DRM_MODE_COLORIMETRY_COUNT
Message-Id: <169409716450.2201230.1132363284756871897.b4-ty@kernel.org>
Date:   Thu, 07 Sep 2023 16:32:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023 22:47:38 +0200, Javier Carrasco wrote:
> The drm_colorspace enum member DRM_MODE_COLORIMETRY_COUNT has been
> properly documented by moving the description out of the enum to the
> member description list to get rid of an additional warning and improve
> documentation clarity.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

