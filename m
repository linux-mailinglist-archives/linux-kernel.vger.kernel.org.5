Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925097CF32A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344967AbjJSIs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjJSIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:48:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7C10F;
        Thu, 19 Oct 2023 01:48:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D02C6607322;
        Thu, 19 Oct 2023 09:48:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697705304;
        bh=/BFGk10tJjdGi8ZC+k20TXUYuEY9bU4gZOhY1NmRH4M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=blxTpEVuBwBTp3VTVME8VhWvZxYN+1GFZOnX8n4Ckh3h4JAJHFOXIrnoGtsSwYQzD
         +wP2btruyVVFmob5omYRTLDjOArySMB7uVoGiwWNlgPQbMN3rXo9HdJgsZtvRHTiim
         UDhSewj75kIMePj/MDIKTR0zEVNIgU+Wq+4VI3/fK18sB+6ysUvwpcKlCRkvl6/727
         22+4dt3Vq1wnNul1fbEgDqUjColnop/zNlccBfof0nLdsaIP/CrU4MOa7wyzMSSMFR
         bD0pf5Vzs5lyWqnR71Uoa0aAoCzH/PPUM0nUgYKQq+wkxTsFC989IfawUPgu54Lqc4
         lw4O/RJfB60Lw==
Message-ID: <8de0772b-3145-44e3-8174-702c7dc729bb@collabora.com>
Date:   Thu, 19 Oct 2023 10:48:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 1/2] ASoC: dt-bindings: mt8186-mt6366-rt1019-rt5682s: add
 RT5650 support
Content-Language: en-US
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, trevor.wu@mediatek.com,
        jiaxin.yu@mediatek.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231019021133.23855-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20231019021133.23855-2-xiazhengqiao@huaqin.corp-partner.google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231019021133.23855-2-xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/10/23 04:11, xiazhengqiao ha scritto:
> Add new sound card "mt8186_rt5650". RT5650 comes with amp and
> earphone codec.
> 
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


