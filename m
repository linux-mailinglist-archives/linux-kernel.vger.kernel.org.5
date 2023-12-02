Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1326801B93
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjLBIwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:52:45 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE9EB;
        Sat,  2 Dec 2023 00:52:50 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F167020009;
        Sat,  2 Dec 2023 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1701507169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddbaMKtPwL33z0vbJqF3KIOjPGvuVw+bjm4FDZ30cJw=;
        b=MImHQNG5Ii9RatL5upAN8aIPNadAgJxmCKD08WX7dQIW3E16gLNltEfRjKRmIM4KazEhBD
        2WvCfJJP/vO/aUtRRLyGBEx4HHvUUg7Si7+Kf0rO0qwsyZWaBeOEitRhWWyI4HZA7OieRp
        igMmdtRXAnGKjXRvlf1ikXiFEu5iU8qX19mbUTcZ0Wm2CU7NeO6LY9vZs4ykufIQh2SoTK
        Nxy0g+78K1hQbTUE1GdzmCqAjNK7GzGtYT9YUYaPJouoMDGFebByhlMVbJYbquME7Vd5xC
        NwIs15iMJW7u2fVGfpPllPgHswuPKlzbIIsni9/2ob0q8gJMfCsXIXMcHox9XQ==
Message-ID: <45221d69-a780-4e81-b4c3-db1b9894a1db@arinc9.com>
Date:   Sat, 2 Dec 2023 11:52:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] MT7530 DSA subdriver improvements
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231118123205.266819-1-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can I receive reviews for patches 6, 12, 13, 14, and 15?

Thanks.
Arınç
