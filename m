Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB077ADD58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjIYQo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjIYQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:44:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D77C9F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:44:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D5BC433C8;
        Mon, 25 Sep 2023 16:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695660257;
        bh=OSniNe/SEUwj5JtrJjV3mo40KgZweC+EN5DVdS+32V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tx2vsX3+bmbaJmQavOlsuRE97YZs+Tfad0mvFjzqoghAnsr99IgCTELCcGsFXK/tF
         5SE21DNJRy/kCAsDACFgx5S5YPFRSvwdvNRNtSPv0drdZxHy4/z8B+wcJThmOYDwvq
         4rpGU+KzSew2sBj8H99H3HB+rQc2ivg1u6rthJ5IVb1gXPPkWvjIICH/G3Dax1HDCq
         7FXAcBWCH/dTXk7+tAUHt4m3Kck/EuSkhoDjFapTm4y+m3KqzuypPEIL84djKjXKyw
         zd9nVFjM/sJFifaVSxjPYfA2Ttw4b77Lv4H/60eUCIWEk3/s7qu2EmtRUwxTZOqOpa
         4U7CojDULiHwg==
Received: (nullmailer pid 1490675 invoked by uid 1000);
        Mon, 25 Sep 2023 16:44:15 -0000
Date:   Mon, 25 Sep 2023 11:44:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [v1 1/2] ASoC: dt-bindings: mediatek,mt8188-mt6359: add RT5682S
 support
Message-ID: <169566025430.1490621.9358539140957587506.robh@kernel.org>
References: <20230925083847.1496-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20230925083847.1496-2-xiazhengqiao@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925083847.1496-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2023 16:38:46 +0800, xiazhengqiao wrote:
> Add compatible string "mediatek,mt8188-rt5682" to support new board
> with rt5682s codec.
> ---
>  .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

