Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB058073DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379304AbjLFPmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379209AbjLFPmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:42:36 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F43C9;
        Wed,  6 Dec 2023 07:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=if2j3C6d/+pnayeOlcBvMhQM4c/lS7P9IrW3mrPNswo=; b=XZA5LCAp4+fwMZshvtTDOiUL36
        eMKdjVkMDzCqoD7bsFLtqytEMpeGiRlmA2Fxhp6zNNS2Dpcrot+1S4422F6GOcuY9BHLdMmnAGjwB
        trMc05URJQxwXtFjWpf3EhJUX9n7hQYtZXVnmQXiE/HiaZWzs1no9x3iKWW/TzWK/+VM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rAu2l-002Dmu-7l; Wed, 06 Dec 2023 16:42:35 +0100
Date:   Wed, 6 Dec 2023 16:42:35 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Daniel Danzberger <dd@embedd.com>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: move ksz_chip_id enum
 to platform include
Message-ID: <dc8926e8-0a73-48f8-894c-781292390929@lunn.ch>
References: <20231205164231.1863020-1-dd@embedd.com>
 <20231205164231.1863020-2-dd@embedd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205164231.1863020-2-dd@embedd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 05:42:31PM +0100, Daniel Danzberger wrote:
> With the ksz_chip_id enums moved to the platform include file for ksz
> switches, platform code that instantiates a device can now use these to
> set ksz_platform_data::chip_id.
> 
> Signed-off-by: Daniel Danzberger <dd@embedd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
