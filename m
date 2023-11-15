Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DA27EC1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbjKOMLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343634AbjKOMLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:11:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69728C7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:11:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8CFC433C7;
        Wed, 15 Nov 2023 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700050300;
        bh=ZXoSnXWsERn/N+r/CYTaTn63bZ2yFqm+Ow/x7XJHIH0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Qk1c++jtUqZ0wE+CyEnTXBDOu1546+yBeP8MYpWVR4TclCtUCDinw6/VDhD7dQhrF
         9F7e0N2xiPm22eYnsLxqoL2pSVrBiMJ1OISG2gyRj8dL2wdrLhyg63RG7r4CCmVyqX
         7l9SxaEn5Mlheg8PXxWnY49CtOw3nVLOkB4iVe2d/LNgi/yIOiqYfqoUoNv6M74JvQ
         Wc99L032FrInN67+iReePgr3z2ab/7Wyak7HVD9WnGR6lNw687wZ5YzcDMElmNTQnt
         C5B2QVBfFGJFI86ybJoi4WjRlYdssPB7yiOtYBQPkTY9efeY4ao72hgXlbWpARfIxT
         hc6zSp9b5iBCA==
From:   Maxime Ripard <mripard@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marco Pagani <marpagan@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231115103537.220760-1-marpagan@redhat.com>
References: <20231115103537.220760-1-marpagan@redhat.com>
Subject: Re: (subset) [PATCH] drm/test: rearrange test entries in Kconfig
 and Makefile
Message-Id: <170005029806.2887518.7822762472748927207.b4-ty@kernel.org>
Date:   Wed, 15 Nov 2023 13:11:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 11:35:36 +0100, Marco Pagani wrote:
> Rearrange entries in Kconfig and Makefile alphabetically to make room
> for additional KUnit test suites.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

