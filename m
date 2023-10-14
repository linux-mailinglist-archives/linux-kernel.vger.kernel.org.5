Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2DB7C932E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjJNHWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNHWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:22:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AF2C0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:22:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6B1C433C8;
        Sat, 14 Oct 2023 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697268135;
        bh=1Mn3itnZ++kLmHTllHIv3u1PhkC+lhf7TcPUsCNOnQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8PPVnunTR5XP3yBL2B/MF92o2F2m05v7i68U9+6gy+VCthVJIYMylBMJ3z1XW1m8
         RfPPg6MLSbIBSw0xQ9G0x7gmLizGKW1k1MsPmVIG4x2Jfj6W2ezdvmsQlw73LoK1HS
         ngTK6qub2ePbrR+sj2cfvvVIo0n/5c7LdHX0B/H1s5cYulJ80nyyVsKN3sJdHX/Prz
         vqiHcT4z+mfajmG88Wu+0YnTxoydsncl9yPQhZ594esvsNXHL61qCX9If89Ty0lrxW
         pdc+Pzins8HQ96uR6BNmj3n3kjNo+ge981HvvtGX9usc7v2oO8oMXXgwCDoirK70VJ
         IFhgUDResLLdg==
Date:   Sat, 14 Oct 2023 09:22:12 +0200
From:   Simon Horman <horms@kernel.org>
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: net: wwan: wwan_core.c: resolved spelling
 mistake
Message-ID: <20231014072212.GT29570@kernel.org>
References: <20231013042304.7881-1-m.muzzammilashraf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013042304.7881-1-m.muzzammilashraf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 09:23:04AM +0500, Muhammad Muzammil wrote:
> resolved typing mistake from devce to device
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> 

As mentioned elsewhere, the "changes" text below is usually
placed below the scissors ("---").

I'm unsure if a v3 is warranted to address this.

> changes since v1:
> 	- resolved another typing mistake from concurent to
> 	  concurrent
> ---
>  drivers/net/wwan/wwan_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I confirm this corrects the two spelling errors flagged by codespell
in this file.

Reviewed-by: Simon Horman <horms@kernel.org>
