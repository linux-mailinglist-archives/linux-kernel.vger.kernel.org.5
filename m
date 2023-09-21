Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECB37AA28F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjIUVUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjIUVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D06199F;
        Thu, 21 Sep 2023 10:03:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3065C32785;
        Thu, 21 Sep 2023 09:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695290169;
        bh=09kWOviwU8Qq3Q1AtI4Ix7ziFVr5rGUXhakqZ9Ah6PM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JBWtRMSyPNz5c0Zv8v1w/VHBmMBGVqJcRd7zqj6eY/G/iLAkI7LpzVmcg+9tqQyZB
         tqVrwF0EL6F5s+Zs1P1srcW1DBN71G/JIKvHJFBsBQjl2N1sRYK48FQHTc4YoZEid0
         h6Kw22hnn2KhepUKjGSkTYsbry8o1AM5oCPD+EzNWxvMYwyA406xFgzgrQXmtDVwfY
         IAAOsbDvLfe/dmJM9Ih8gHZxtkC2NN2R/3MRUAaAfLIzanPtYj/FjIy7Pe8kAZDEF6
         Qv8Qt3+CqyrnlzSkfHtM8+7ZAMZR3OO1knsFzimmISsQwXgFy3l+rv3YWL9+Rn2kGJ
         QBvnoUHuS46Sg==
Message-ID: <b7fb6eb8-77a1-8285-4fab-04949bf86c6b@kernel.org>
Date:   Thu, 21 Sep 2023 11:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8-ss-img: Assign slot for imx jpeg
 encoder/decoder
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mirela.rabulea@oss.nxp.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230921063620.22962-1-ming.qian@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230921063620.22962-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 08:36, Ming Qian wrote:
> assign a single slot,
> configure interrupt and power domain only for 1 slot,
> not for the all 4 slots.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Meke these proper sentences, so starting with capital letter and ending
with full stop.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.


Best regards,
Krzysztof

