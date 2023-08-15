Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B9077D11A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbjHORc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbjHORcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC44D1BD7;
        Tue, 15 Aug 2023 10:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46D9964AE5;
        Tue, 15 Aug 2023 17:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C917C433CD;
        Tue, 15 Aug 2023 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692120743;
        bh=SkRhyPf29u94NXSe+SgrmqpQYI+LqRjgJJoSkouM+Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvZY4M7FBtrmbWm3RIal6ANh/Nmh4r/KZL9zIyxkWjqBTZFSrGvF4jgxhANIM9F45
         ghaj88bcKERwSlq92nk7NaBIdAO3BAR2W+ucB+0lLQopkE2nsDNPkhAvX4DmmzGl1A
         bCCt0qfsVaBNZROYglKcEMZeO5bgl/GyW3/xfaOVGWkRK6Xxvux3EwqOuFgXEYk71m
         8rNEp35t5Vug0eNbbzaUTnr8K+TpPc24Z/UEyXcZLbGRNwpOLHXnTPNxvmYIiNYoLo
         jDfUI5g6YUEMzynJzjAhAfCXnSJ4KnFdr4L1mrgyvRmCD77OGPbhoZQrp+9wnU9DWN
         aWFSWEdV+ZPkQ==
Date:   Tue, 15 Aug 2023 18:32:19 +0100
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: unexpected file in the mfd tree
Message-ID: <20230815173219.GF648357@google.com>
References: <20230809081524.006da553@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809081524.006da553@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023, Stephen Rothwell wrote:

> Hi all,
> 
> Commit
> 
>   bb60922c31d0 ("mfd: Explicitly include correct DT includes")
> 
> added this unexpected file:
> 
>   drivers/mfd/rz-mtu3.c.rej

Already fixed, thanks.

-- 
Lee Jones [李琼斯]
