Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101C793BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbjIFLzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjIFLzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:55:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07391717;
        Wed,  6 Sep 2023 04:55:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1072DC433C7;
        Wed,  6 Sep 2023 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694001341;
        bh=FDZb2P6B0ZGwz9DnHq2oQkdMxKB5yoZzWthnXB71JxU=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=jhhnLlTyoqdIJqEsBEzcRyQzk5+hGjuuSb/2wrdwqMn9IuYUxHaciHhF6nIkY6VjQ
         VH9qX4Zw31P6hfNBw/Qy7oMaadRuC6kDSqG4q+g76JE/cmIm/sY855HKXvR8xyRGEa
         ZBEHR8ahL4Ha2z247Q7L8FNYnbSc1sWRjXVERfIHw3vJHhjIrg2wQU47v843C39Vy1
         Y0x5A7JtA5Uw02Lw0zFBzYwMn3/X+clluAgYvrukVOlEh50NIGf9GDvHwA1p3/DuZu
         4jClhytET6ay7v47gtPknSh5LW5Grhx5VQ6W7+qMBLloOo+wVZ7yjBWtaTavkPEXv/
         STDBDqEhplRVw==
Message-ID: <54a97af7c14f23ce12be9eb40075733f.mripard@kernel.org>
Date:   Wed, 06 Sep 2023 11:55:39 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Sarah Walker" <sarah.walker@imgtec.com>
Subject: Re: [PATCH v6 08/20] drm/imagination: Add firmware and MMU related
 headers
In-Reply-To: <20230906095542.3280699-9-sarah.walker@imgtec.com>
References: <20230906095542.3280699-9-sarah.walker@imgtec.com>
Cc:     afd@ti.com, airlied@gmail.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, conor+dt@kernel.org, corbet@lwn.net,
        dakr@redhat.com, daniel@ffwll.ch, devicetree@vger.kernel.org,
        donald.robson@imgtec.com, dri-devel@lists.freedesktop.org,
        faith.ekstrand@collabora.com, frank.binns@imgtec.com,
        hns@goldelico.com, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, luben.tuikov@amd.com,
        maarten.lankhorst@linux.intel.com, matt.coster@imgtec.com,
        matthew.brost@intel.com, mripard@kernel.org, robh+dt@kernel.org,
        tzimmermann@suse.de, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2023 10:55:30 +0100, Sarah Walker wrote:
> Changes since v5:
> - Split up header commit due to size
> 
> Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
