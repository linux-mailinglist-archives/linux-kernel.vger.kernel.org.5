Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417AD785871
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjHWM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjHWM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:59:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F268510F2;
        Wed, 23 Aug 2023 05:59:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 558E8650D5;
        Wed, 23 Aug 2023 12:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B65CC433C8;
        Wed, 23 Aug 2023 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692795551;
        bh=F91n1DPn24bjV9MAo7MD0EXAfdliZqVQJAhmLsbo/i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IEzNxaWXC9HS994DnUcnEsFmqtPs1CYCrNBx+UB2lTXrBA2KqA5E1PYSe/FgjC0Vc
         XZtcZmEHSOm+Or62q6hUlcqG3gUiKmryEO9MiZmaw8gajx4ES4T8XcYoByrfP5hS69
         EczqZPwUq/iOsisvwrRxcKdQpGkCk/UF2tEvLbR3Esc6Ib8Un4o5sZSue9xkSRr7dc
         xbp5UFV69cUrSygOupl+XdJQgiMAHrJlITHbqJtvG2+iy28E0Bp4h64aGII0HjZLpc
         9F3wW7DE9waQzuyCVv+zmqigodkFtE1trKtqyRRsr7idMWHp6E0nv1gd5EGkqLhUOg
         rCsJ/4/1so/Nw==
Received: (nullmailer pid 2051073 invoked by uid 1000);
        Wed, 23 Aug 2023 12:59:08 -0000
Date:   Wed, 23 Aug 2023 07:59:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        YHCHuang@nuvoton.com, KCHSU0@nuvoton.com, CTLIN0@nuvoton.com,
        SJLIN0@nuvoton.com, scott6986@gmail.com, supercraig0719@gmail.com,
        dardar923@gmail.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: nau8821: Add single-ended input
 feature
Message-ID: <20230823125908.GA2048264-robh@kernel.org>
References: <20230823071244.1861487-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823071244.1861487-1-wtli@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 03:12:43PM +0800, Seven Lee wrote:
> Add input with single-ended control.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../devicetree/bindings/sound/nuvoton,nau8821.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)

This is the second v1 I've gotten. Is there some change? Please version 
your patches.

I acked the last one which you should add when sending a new version.

Acked-by: Rob Herring <robh@kernel.org>

Rob
