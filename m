Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9167BF6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjJJJHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJJJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:07:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089A6CC;
        Tue, 10 Oct 2023 02:06:58 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B84766030BF;
        Tue, 10 Oct 2023 10:06:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696928817;
        bh=RpOgGZRGVhfUaO4u/weyo+Vj7fpIhUpNL+R1Rudo1sU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f8nnC0tixyeaQ39u6/zLCNXjdI3HCSnbV0aG9spQlHPTvmtsY9fuR/Eg3S4KNwWr9
         xwWd+6bIX27CapM/QJtvN/HV1xGU+Z9iB00208mLMM6o+Ug97skqP6ezFr2YYdQM1/
         7yoh8SzwIBNKh5cSpwdK87bwkQzPPhIuXI7q3gcWlQNFUSzInj6xVY4MQ1x5/62mge
         24qZ58CT09x5R1V/fdhbrQy6piCWQNkeBxm3eQnk2813+63IvY7YuVjTDWS7dOKNLb
         RhWKIhvO/W+/RbTXivZo0SZk3TCBG4f08miEAxd/0h2F+3t3iC37tZhF4c83cxMHbg
         XNj810FLiNykA==
Message-ID: <673dcc99-cf42-81ff-47fe-e20079a5e17c@collabora.com>
Date:   Tue, 10 Oct 2023 11:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [v5 2/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Content-Language: en-US
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, trevor.wu@mediatek.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231010023738.8241-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20231010023738.8241-3-xiazhengqiao@huaqin.corp-partner.google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231010023738.8241-3-xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/10/23 04:37, xiazhengqiao ha scritto:
> To use RT5682S as the codec and MAX98390 as the amp, add a new
> sound card named mt8188_rt5682s.
> 
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> Reviewed-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


