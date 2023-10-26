Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75497D860E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345464AbjJZPeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjJZPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:34:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3094A1A6;
        Thu, 26 Oct 2023 08:34:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77398C433C7;
        Thu, 26 Oct 2023 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698334450;
        bh=WlnOzBHEslW7auiw0OQwFlM3UIEQxiB3h6xa2FYhXD8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XDLhyice58rh/uUv7OvhKCFL0YqZ96mVJJZ7ryrPkBzgCe8Ckc1dwVkcFt8MINDR2
         a8fBohwsAijNXq25EoUNELjMZrV2J5pcuieu1UWPzLVCSoxLWmwYizVsyoWNjWikow
         UgA+lVYBoRj0AcknN1FHOgwkZZUfMHKAhVPW6Rrjo7vZC921i51E6IlnSVqLzgiTVU
         VG8ZuE9kJ5iEjm+HFcgv32oTcM4g3Gu37v7uGiz/ca0shJzGuRpbaQskQ12sT/xv7L
         8fYF2FDSvPane+sX5uC0e3+YrQSiI0O/Py4r/GU8E5zhE9Wpoqgbex9RfodWfBTGV8
         42xuzs5WEvfsg==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org,
        Helen Koike <helen.koike@collabora.com>
Cc:     robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
        p.zabel@pengutronix.de, linux-mediatek@lists.infradead.org,
        heiko@sntech.de, jani.nikula@linux.intel.com,
        intel-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, airlied@redhat.com, daniel@ffwll.ch,
        michel.daenzer@mailbox.org, daniel@fooishbar.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230919182249.153499-1-helen.koike@collabora.com>
References: <20230919182249.153499-1-helen.koike@collabora.com>
Subject: Re: [PATCH] MAINTAINERS: drm/ci: add entries for xfail files
Message-Id: <169833444817.1001410.15120310571741480170.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 17:34:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 15:22:49 -0300, Helen Koike wrote:
> DRM CI keeps track of which tests are failing, flaking or being skipped
> by the ci in the expectations files. Add entries for those files to the
> corresponding driver maintainer, so they can be notified when they
> change.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

