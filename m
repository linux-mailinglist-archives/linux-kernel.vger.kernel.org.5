Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B51E7ABBEB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjIVWlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIVWlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:41:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5EBE8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 15:41:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179ADC433C7;
        Fri, 22 Sep 2023 22:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695422469;
        bh=hPLyooGEXjDQO7zmx/azSWXqBtNWU5gcxUV/qloDfIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMis+nyuHAS+i4eWThT+eJqLZhTdeKA98jZ2F1VHzjUTb+rZjdae/8GHFw1FEysYz
         QR/19Tp2FJMPBgFyFy/+W+2kIDRG0up88Q2nk5VQnZAs4UOzVz8Ah69D4eRhJuVWc4
         nDhE+/iu1ThpYrfYFLQMehuT6I9ohkaV/yPYw/AOILWbzQA33HZu0KlrJaS5L2xAAi
         Ki7+YXfRQ6viWgoNClEnhEFzzLrC7CwbBGaj4eKKGNsdE/dmn2ywJwnaQjqwasmwVB
         wRfNNxKfP97wZdjx+JRWqOZXlVXWT3tjvvPWjnlfW+ueHX7c7ypRjoidsBMnM2ukv9
         ljzVtmYJ+4eZA==
Received: (nullmailer pid 4054192 invoked by uid 1000);
        Fri, 22 Sep 2023 22:41:07 -0000
Date:   Fri, 22 Sep 2023 17:41:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc:     devicetree@vger.kernel.org, sinthu.raja@ti.com,
        linux-arm-kernel@lists.infradead.org, nm@ti.com,
        robh+dt@kernel.org, kristo@kernel.org,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 1/3] arm64: dts: ti: Add USB Type C swap defines for
 J721S2 SoC
Message-ID: <169542246631.4054136.7526733156419705188.robh@kernel.org>
References: <20230921100039.19897-1-r-gunasekaran@ti.com>
 <20230921100039.19897-2-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921100039.19897-2-r-gunasekaran@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Sep 2023 15:30:37 +0530, Ravi Gunasekaran wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> Lanes 0 and 2 of the J721S2 SerDes WIZ are reserved for USB type-C
> lane swap. Update the macro definition for it.
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-serdes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

