Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF3F77B57D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbjHNJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjHNJ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9012113;
        Mon, 14 Aug 2023 02:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F52361032;
        Mon, 14 Aug 2023 09:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE7CC433C9;
        Mon, 14 Aug 2023 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692005289;
        bh=jMOZKlz2rARelEyyH2//udpyLzWyERLcOWYIv6Ii2CA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=F7nCMKGjDGD20obthE3Qh+xDyBwttXFVqhdehGTXYfoVSgf0cH5esEVCyQQ1AhENY
         gVVJ240po2MfKBcV/rsVCnC/a+hG9ESzdLfhE4re/rDu6znGBh/LqqGFscJqJm2dh+
         Nuw9Lx+cxdRyw011J456wPDhvjcKtD8emfy3y3wlZXHEtEshOFRNzHvStkAx86WQ42
         GAmlx2kRxFQpVizLx/+iH1aH46xfxVtpHX0278eosKMpQ/LIJPJOmoiUwP9k2/j5xe
         +cO07lJnbJVJaRm5jl3d2WfXxEI7ez9WTKB3btPY8wpPXg4Gh4G4HNgUjG4OgZuTzb
         OJ4qrJVtZv6NA==
Date:   Mon, 14 Aug 2023 11:28:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Bastien Nocera <hadess@hadess.net>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v6] HID: steelseries: Add support for Arctis 1 XBox
In-Reply-To: <20230703181115.61975-1-hadess@hadess.net>
Message-ID: <nycvar.YFH.7.76.2308141127490.14207@cbobk.fhfr.pm>
References: <20230703181115.61975-1-hadess@hadess.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023, Bastien Nocera wrote:

> Add support for the Steelseries Arctis 1 XBox headset. This driver
> will export the battery information from the headset, as well as the
> "wireless_status" property.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

This is now in hid.git#for-6.6/steelseries. Thanks,

-- 
Jiri Kosina
SUSE Labs

