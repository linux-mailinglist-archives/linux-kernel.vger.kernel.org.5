Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AECE786AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbjHXJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbjHXJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1577172C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90219616BF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8330C433C8;
        Thu, 24 Aug 2023 09:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692867645;
        bh=2cwavp21DLeJaqoDt5IpKVGXDxRDNMOuJaOPQUqBBk0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mDW0sEKmulEIIl0GHit8PAiJLckNsPDWQeXyvZn4kMRAM+833ReYvfkGYZd46HNdq
         PEWXRi9GOXT1YNqBN9xrcylOuDPBP2VbHuolxyzhfpIO289c/3SYh0957WdG62BDtK
         L1QKdiRClcv85ArFQJTpaqyqc+PT1J+1lvVhvFC/JE5kT49Xa26HDZtksTqW3RWHyQ
         pPUwt3e8uQaaKFkRHDC9NmMihh6cTaOy50XjhzuwpbAGh9ct8MJJVU/lkUz/hYAxtz
         CLmns62ALQFmDhQYeo3C41ifDqjaJxso1nu9Dt91+5Q11hiGzw0XNL6xhbeDpwB5T1
         LCpV0dDns383A==
From:   Maxime Ripard <mripard@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20230824073710.2677348-17-lee@kernel.org>
References: <20230824073710.2677348-1-lee@kernel.org>
 <20230824073710.2677348-17-lee@kernel.org>
Subject: Re: (subset) [PATCH 16/20] drm/drm_connector: Provide short
 description of param 'supported_colorspaces'
Message-Id: <169286764260.453632.11434597812331392419.b4-ty@kernel.org>
Date:   Thu, 24 Aug 2023 11:00:42 +0200
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

On Thu, 24 Aug 2023 08:37:01 +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/drm_connector.c:2215: warning: Function parameter or member 'supported_colorspaces' not described in 'drm_mode_create_hdmi_colorspace_property'
>  drivers/gpu/drm/drm_connector.c:2239: warning: Function parameter or member 'supported_colorspaces' not described in 'drm_mode_create_dp_colorspace_property'
> 
> 

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime

