Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCC98053ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbjLEMPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjLEMPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:15:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CC5197
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:14:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415B0C433C7;
        Tue,  5 Dec 2023 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701778497;
        bh=HjMd4iX91mq4MvNdXHxBkGTsDeJEpwGGckmiE80C1qY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJo7sqDpCBu9Pl6UktPypByioNz8CU4rHhyEGqRhc7gZyD6jy4d4dGXSOrQUdabwk
         U/Y9sGivAKffNaj8T2n0IKb8vFh8ceg2iKUV7jdp5K+Hn18L+WeTLM2gci5MB1gSJZ
         oameCqLh/rxXe/YOEpyt6WGgrt8tRqeNB7fl475IKJBZLcEcOLwyqpf0EZNp7ecjwo
         VxOaGLiohvOyHwlEWAeOR0akgUXFn1MFBAH3hWlWqXsbW+Nfhg3mJpDpMCRf0CEzDu
         YvBKHdAz7P8M58SoedxziqE3Ev0ub0aVrJfRZ5GnP8e0KfnUkQDOzYlrrtmOfndQ8A
         TlgbegY2KWfNA==
Date:   Tue, 5 Dec 2023 20:14:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?iso-8859-1?Q?Jo=E3o?= Rodrigues <jrodrigues@ubimet.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)
Message-ID: <20231205121451.GD236001@dragon>
References: <20231102231130.13ca0513@pcn112>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231102231130.13ca0513@pcn112>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 11:11:30PM +0100, João Rodrigues wrote:
> From: João Rodrigues <jrodrigues@ubimet.com>
> 
> TQMa7x (revision 01xxx) uses a LM75A temperature sensor.
> The two sensors use different I2C addresses, so we can set both sensors
> simultaneously.
> 
> Signed-off-by: João Rodrigues <jrodrigues@ubimet.com>

Applied, thanks!
