Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9937A4693
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbjIRKDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbjIRKCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:02:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CB4133;
        Mon, 18 Sep 2023 03:02:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E93EC433C8;
        Mon, 18 Sep 2023 10:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695031339;
        bh=Je/16HiNm+mVAuAQ2J+Ice+5GbTtVjM5LaV9JBki6y4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SkFvP8Oco1kkq44RFieLc9vcVNvQTX7qenUI9CHhSJ7JUpY5D4d3OgGAkrOSo9s5J
         E3DV0aMAd9L9zUAjYL8MN6LaorwqMF+QC4qCJZMd0eHSNOBsZlMUTyupZNq1yQhP+C
         8w4UN+h1fZAOIKWfWnnKRC4B/FhEcEU0VELB6jr4pqSm+LVz2rdheqoA6x2SzTy7O9
         YXoxFwx4RWQanhhvByggOm4pof6LxvIbhN4S9JZVQVL2wKM85dHOV6DVAEbpIbNWrs
         MpUYnxWn8ZSigzAs/vxqH93BV7hfXa669GyCpZWj4tJgsE9fQBM4IPSTy3d44mooUS
         5B/cDMEmSR+4w==
From:   Robert Foss <rfoss@kernel.org>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        hverkuil-cisco@xs4all.nl, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     jonas@kwiboo.se, airlied@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, daniel@ffwll.ch
In-Reply-To: <20230909144432.34972-1-jernej.skrabec@gmail.com>
References: <20230909144432.34972-1-jernej.skrabec@gmail.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi-cec: Add arbitration lost event
Message-Id: <169503133690.2474759.8647020524876306057.b4-ty@kernel.org>
Date:   Mon, 18 Sep 2023 12:02:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sep 2023 16:44:32 +0200, Jernej Skrabec wrote:
> Add handling of arbitration lost event.
> 
> 

Applied, thanks!

[1/1] drm/bridge: dw-hdmi-cec: Add arbitration lost event
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=484281d5436c



Rob

