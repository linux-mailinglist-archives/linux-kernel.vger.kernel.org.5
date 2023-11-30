Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A3D7FEBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjK3JSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjK3JSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:18:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6F9D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:18:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F31FC433C7;
        Thu, 30 Nov 2023 09:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701335928;
        bh=2DEa1oTeYKzcAD8G7sQTs3Ut9U8iyHfVccBu5egHOjI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o8wRZOhEkeRvlklnE4tOYqWrtRs3q162YaAbPlJInXH/gblUtFqSU9ZX4j9Pw5LxC
         r4WdQ8NrZrpFTrypDvOoMHiaaxmbte2641LIsXqylz5noP7Cw7azIWhAOSq+ae49dy
         Lj4PSYlotWGs5klPsoL3LWQJOkDXU90iap26FZiImBB5m2PsF7OM10WrtbBflOPjIV
         Z7LGjjNVJlnWmFrbcjSSHmg0xJOS0hhpfwXPz5oq3plcgySXhk2ytwkID3vtbhc8dp
         JLceUBMAkcgOuT7pnsND6OgXAtxSqrossnpU5qq4v6Ap5AP1AnBR/7CeFxK3QTiIgH
         GbtYIh5g/0xVg==
From:   Maxime Ripard <mripard@kernel.org>
To:     Sarah Walker <sarah.walker@imgtec.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <1649c66b-3eea-40d2-9687-592124f968cf@moroto.mountain>
References: <1649c66b-3eea-40d2-9687-592124f968cf@moroto.mountain>
Subject: Re: (subset) [PATCH 1/2] drm/imagination: Fix error codes in
 pvr_device_clk_init()
Message-Id: <170133592547.3076107.13433304764452948026.b4-ty@kernel.org>
Date:   Thu, 30 Nov 2023 10:18:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 10:26:29 +0300, Dan Carpenter wrote:
> There is a cut and paste error so this code returns the wrong variable.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

