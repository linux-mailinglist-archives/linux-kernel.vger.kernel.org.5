Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9890E7D837E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbjJZN0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJZN02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:26:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B457CE5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:26:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FCEC433C7;
        Thu, 26 Oct 2023 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698326786;
        bh=41Xg+Doxc4aBDvl2iYiwfP8OIdQnKvWUYMtMk4RePuQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YyTcABChaU6MYFY2UYYfXz8rPw658AKaFaGnP9VQyN+R04Et5KHx8w8GZ9/Rlz/JQ
         bEixMV4D3I7Zn5hcQnjuWs7XZSDGl+r531/f2zF819MLd3udsnMwiBpKU1r+KQiUT2
         XVPabxKNULHZtBF87OPVEaV7o+Qr3PeoMCJljGoq4Al2RQ8IyatksKj3UtktfeDjL1
         mfJmiPLxLB4vf8RSClf2mhnQuiGb/ve+R6Fh+4Z8j+DHtq9s69l2bDDW/j5uLj2R4L
         vs3TDYxEwCwT6zPeDsNKtr2+Ezl/bovnII3SJbN2JgubIwMcxIUQnj55aUPnIEd9sx
         DxJUtM3CBoC9A==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Cc:     Emma Anholt <emma@anholt.net>,
        Helen Koike <helen.koike@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
In-Reply-To: <20231002164715.157298-1-robdclark@gmail.com>
References: <20231002164715.157298-1-robdclark@gmail.com>
Subject: Re: [PATCH] drm/ci: Enable CONFIG_BACKLIGHT_CLASS_DEVICE
Message-Id: <169832678386.958223.2789362196867076790.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 15:26:23 +0200
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

On Mon, 02 Oct 2023 09:47:14 -0700, Rob Clark wrote:
> Dependency for CONFIG_DRM_PANEL_EDP.  Missing this was causing the drm
> driver to not probe on devices that use panel-edp.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

