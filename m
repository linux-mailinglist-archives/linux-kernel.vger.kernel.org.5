Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D391275ED3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGXITU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXITQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:19:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E6198;
        Mon, 24 Jul 2023 01:19:12 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 497C26607029;
        Mon, 24 Jul 2023 09:19:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690186750;
        bh=gBQZn3CBVzSSUQuQhiQ/sMga7mNoQxmP14hkArh6+tc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k4qhWOQ0EpeQPuilqCex3htPrIbtXEuyKzFuqeiDk++TLGT0zZ0A13VZZqzUVJjQ3
         mAEnwYp2wYosdzNioE2/KOTch9UhkDwZtorSJhIq+Ape1A749CB7liJkvjsjasWwYc
         SFiFDEPVZ/O1gQu2MXb6oOfIf63k95YWn53UXI9sxVShhclTMZtv276AoryfId+qGW
         Y7F+IlaB9ubURhixxnVjbq/KcKHrlWZrXCS6uRexGDDqn0/bMqMXhE9Ro3iNm6HezR
         cCHyMkGQGLs1zZKDI3GatgII4XgwosRBB+muWg6riEUrO64lB+S1cgZF5N565070ew
         ArrbxpFkgAMHQ==
Message-ID: <56e5f094-7032-ee0a-6824-3292f4b7c707@collabora.com>
Date:   Mon, 24 Jul 2023 10:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/5] arm64: dts: mediatek: Add spherion-rev4
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230721201705.387426-1-nfraprado@collabora.com>
 <20230721201705.387426-6-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230721201705.387426-6-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/07/23 22:16, Nícolas F. R. A. Prado ha scritto:
> Add a devicetree for rev4 of Spherion. It uses the rt5682s audio codec
> instead of the rt5682 used in the previous revision.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


