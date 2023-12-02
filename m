Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD735801F30
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjLBWnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBWnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:43:11 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B565A4;
        Sat,  2 Dec 2023 14:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=wsur4cooD2ikDX+1j0hmv8bEdcDbDiNq3c9HAKF1KWc=; b=Le2RtE6aBoIgT9mlf//zAabcom
        uKLh69SyRu0EerJs4Sug8CgghxI3GL2ygkjqTFocDILg8dqNtkxxFM9o5Ew3v4iBSrH9fZfNfIS0Y
        If5GIQmFFEdXeBDIvWiREQYMFH0rPCc6P+ymQzGBx/kuCyq9cyvWdpBFSt6pOGV5Osb4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r9YhE-001s1i-4q; Sat, 02 Dec 2023 23:42:48 +0100
Date:   Sat, 2 Dec 2023 23:42:48 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Heidelberg <david@ixit.cz>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Rosin <peda@axentia.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] ARM: dts: marvell: make dts use gpio-fan matrix
 instead of array
Message-ID: <cb86b7bd-7dec-42dd-8d90-fa0eea321ae1@lunn.ch>
References: <20231202222934.137191-1-david@ixit.cz>
 <20231202222934.137191-5-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202222934.137191-5-david@ixit.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 11:29:04PM +0100, David Heidelberg wrote:
> No functional changes.
> 
> Adjust to comply with dt-schema requirements
> and make possible to validate values.
> 
> Acked-by: Simon Guinot <simon.guinot@sequanux.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
