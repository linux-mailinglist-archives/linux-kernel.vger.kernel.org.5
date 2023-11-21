Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20F07F2A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjKUKe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjKUKez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:34:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AADBA;
        Tue, 21 Nov 2023 02:34:52 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5A27966072F1;
        Tue, 21 Nov 2023 10:34:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700562891;
        bh=qGOFfzHTmwNO8RaarKDI1R8ZcBkTKNwdJlZZMnC9tRI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Q9F9dqLSfls32qYiEb/6t/KTwMWLSUbv+68gYPu2dFnWkfDDctkW6vo/ZdW0ZlTUI
         qxORoz/OpTPeH9gC/5pTn44Jop8VEogD2yaqTqx4cw4VPNDdlpwX1RvQpk8VBoufmC
         X/c0wIzux+HzAzFnTDUKY0WTR31p6nczGnHyacxzo6p/86eyyAl9bz1u78Bef885LQ
         /cTJFSJ64byVuIEQLNfxvK+JG+At7xN/gCtgMYC86zj3wm4NCYpusd2erhMFp5+eG1
         bwJU64PNkz+qRgIxdyBqgxhGJfjpp6Um+CunVgX2zuxYAe3lkY7ksdJ+xmZl7N4G07
         65H69uQ4DnLBQ==
Message-ID: <88b34ca9-97e6-4a62-bcd8-19f3f3917d8d@collabora.com>
Date:   Tue, 21 Nov 2023 11:34:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] watchdog: mediatek: mt7988: add wdt support
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <6478f8d2af59736d23a96b52891bb541de33870d.1700504385.git.daniel@makrotopia.org>
 <c0cf5f701801cce60470853fa15f1d9dced78c4f.1700504385.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c0cf5f701801cce60470853fa15f1d9dced78c4f.1700504385.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/11/23 19:22, Daniel Golle ha scritto:
> Add support for watchdog and reset generator unit of the MediaTek
> MT7988 SoC.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


