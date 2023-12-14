Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43847812532
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443042AbjLNCXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjLNCXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:23:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C966E3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:23:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50EFC433C8;
        Thu, 14 Dec 2023 02:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702520597;
        bh=1hsHfZMQC4eUNJ2+GpZd5FIgUk678/Zs/nnQW+BnRlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EiPKbKMRyTckAZrYG7JYPcXjOBFIUfMSNM7Iov4riQTnfI/WQHFs2n4G8LdvnFVaz
         oj2A/LYv97m4q1yQntR//Fmj/o4mphZcsePrDxFlfw34FeoQoGKYIye/821c14XJWl
         rUxfkLQe/Di0DEK7meNh/ht5ntos9qtqOtmZWdgE9GbI7t77CktcKP34M6C7IqRXVu
         kbR56HNWiaQqbOdJUzciuLgFDdJ/XboaWfCGKCBt67emqcA+T4BcPzl/Efd8Eg2+On
         ZYx67egRwc+k9JhncJNScq7UaYQLNiPXVkI9RbpFlYUuolOUz7fX01mWXciuS1UKhl
         do5ZsBOBhTe2g==
Date:   Thu, 14 Dec 2023 10:23:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Enable Overdrive mode
Message-ID: <20231214022312.GZ270430@dragon>
References: <20231128211832.313544-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128211832.313544-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:18:31PM -0600, Adam Ford wrote:
> The i.MX8M Nano supports and overdrive mode if the SoC is given
> the proper voltage.  Add imx8mn-overdrive.dtsi file which can
> be included by boards who support the voltage necessary to handle
> the faster clocks.  This increases the GPU clocks from 400MHz to
> 600MHz.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied both, thanks!
