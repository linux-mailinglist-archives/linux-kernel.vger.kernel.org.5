Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921657FC283
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376307AbjK1R7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346883AbjK1R6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:58:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A24358C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:57:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC732C433C8;
        Tue, 28 Nov 2023 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701194267;
        bh=NGmfjNMsc8MTcobjGt/SD7zw/1t1pkX0VqePmSopdm8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dTXC6egirGlbMaSupo1pofhXHH5Crhtyt5gOzv2fhTahh0xcxufVmu0fr68m+mfxy
         45npWDLjm4Kh1nFDmMF5KyDrkqAGX5Y/FlKV0HjtF+qhvV/TicDBj/Ze5vbBwmaZ/a
         UJw+D9Eadpcr3FsNSqU6tc1nDWgsje64YqJxnK5HhceN4tzGlzZ1gGTmaLhJWLxOSO
         fyySka2RHYSHWEwd4tli8vA6eBamVtWoRb8vTtjUAJ+mxmqcARrBJy+fD5EX2rztTQ
         8qHq6rqWgbEWFDaRrrCBdO2ebnc2kRhRex4FgnQLrc8PB1GBJeIjA5MB9u4IAqj7a6
         YMQukS9DakoGQ==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>
Cc:     frank.binns@imgtec.com, matt.coster@imgtec.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch, corbet@lwn.net,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20231128173507.95119-1-donald.robson@imgtec.com>
References: <20231128173507.95119-1-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH] drm/imagination: Numerous documentation
 fixes.
Message-Id: <170119426454.2880479.7880420344825217508.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 18:57:44 +0100
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

On Tue, 28 Nov 2023 17:35:07 +0000, Donald Robson wrote:
> Some reported by Stephen Rothwell. The rest were found by running the
> kernel-doc build script.
> Some indentation fixes.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

