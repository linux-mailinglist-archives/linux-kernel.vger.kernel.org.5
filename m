Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1147C470C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjJKBKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJKBKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:10:12 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6348F;
        Tue, 10 Oct 2023 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=JPiec/sCUcZurkwmie2nYwKp09sLIt0E6Hpr773cJDg=; b=nFfJb4mJ5K9YVo0uqSKDpTjUrz
        boYCeR91Gw/HrNAj9kJXXhIf8EDyoSamrLURlN5nrshZXtVdCjxresFUw7WEMYMLsYgxZnGzUXQVY
        I+dIMBJAkxeTS7tlxIkvrTMeDZzluO31ScWU14TqRvL5I0lUsOBXz5dUNCPstacfqQ0I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qqNjR-001PVB-Dw; Wed, 11 Oct 2023 03:09:49 +0200
Date:   Wed, 11 Oct 2023 03:09:49 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: dsa: Use conduit and user terms
Message-ID: <63f3e1f4-428b-42d2-a5ac-c6445af195f0@lunn.ch>
References: <20231010213942.3633407-1-florian.fainelli@broadcom.com>
 <20231010213942.3633407-2-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010213942.3633407-2-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -Master network devices
> +conduit network devices
>  ----------------------

Hi Florian

It would be nice if you could do a case preserving search/replace.

I think you also need to fix markup like this, or there might be
warnings from Sphinx.

Conduit and user are good replacements, BTW.

	Andrew
