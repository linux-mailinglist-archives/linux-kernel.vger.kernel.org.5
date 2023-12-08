Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6179D80A10C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573600AbjLHKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbjLHKca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:32:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F502D54
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:32:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0DEC433C7;
        Fri,  8 Dec 2023 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702031528;
        bh=yZ0ArCVZudWIJRxf5rXx4mNCVgyBX4eaw15oShBLaj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2kYfjQhCxHl1hqoP+X9utK90pgdDIZNrPx/DP75cUl1gjWVOtlC3o5pt5gf6mzH0z
         F9iRt3vUy7/em+JQda3xeG7X7OHH0Dw6RU/lcLAnShDjxSUchH4obGtDqNr9ucLQKa
         sYmzyN+eWIYYdCf9KWrAhVuJywNPT2lKG/dwKJHM=
Date:   Fri, 8 Dec 2023 11:32:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Ian Ray <ian.ray@ge.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        kernel@collabora.com, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCHv5 0/2] Fix imx53-ppd UART configuration
Message-ID: <2023120821-sandstone-lavender-7487@gregkh>
References: <20210430175038.103226-1-sebastian.reichel@collabora.com>
 <20231208090754.fn3bddlum3t7kakn@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208090754.fn3bddlum3t7kakn@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:07:54AM +0100, Uwe Kleine-König wrote:
> [Cc += dt maintainers]
> 
> On Fri, Apr 30, 2021 at 07:50:36PM +0200, Sebastian Reichel wrote:

You are responding to a message from 2021???

I can't remember what I wrote in an email last week, let alone years
ago, are you sure any of this is relevant still?

thanks,

greg k-h
