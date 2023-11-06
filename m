Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF27E1B5F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjKFHjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjKFHjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:39:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C315D93;
        Sun,  5 Nov 2023 23:39:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F87C433C7;
        Mon,  6 Nov 2023 07:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699256360;
        bh=vyxEvGRUDovU/yopk0L89IasyadIYEk7FbXC3tlcwA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AHTwx1NTa4yF0O6w/ZiqG9IyGBtF56LygANoAOLAcHFeo7q1J6iImQpzaBnvA2PjU
         kQrFpiYFTMy70Z/N6njAypLa8QmgZThVhhLaHTXJ0NPhpWPIbB4TIwLkT/bbPRVB5d
         OlvxcuDXUHcfrOWX37Ok3XAYXyiGsNXon4uz5hhHT4jhrqBz8OGeTJ3Lct85l+4U+q
         Xxm9FUiyt62y4C1IUCdqcMDDNp9kDNj57F0K9p6exTMO9xch7YmTf9H1IksfBnc6wW
         kQsmK2h6W/Mpdfxuz2B8rN3rD4ZPoRopsVH7yufzjsPr3t/Ov89kcUQwma1cZr14AZ
         fMgtRGxw4Y6og==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qzuDN-000628-0P;
        Mon, 06 Nov 2023 08:40:05 +0100
Date:   Mon, 6 Nov 2023 08:40:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: defconfig: enable newer Qualcomm sound
 drivers
Message-ID: <ZUiYVQT5J9tJzh85@hovoldconsulting.com>
References: <20231106073048.24553-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106073048.24553-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 08:30:48AM +0100, Krzysztof Kozlowski wrote:
> Enable the sound machine driver for Qualcomm SC8280xp soundcard (used on
> Lenovo Thinkpad X13s laptop), Qualcomm WSA883x (speakers on X13s) and
> Qualcomm WSA884x (speakers on boards with Qualcomm SM8550 like QRD8550).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Resending with corrected recipients.

I sent such a patch a few weeks ago:

	https://lore.kernel.org/lkml/20231012080157.4616-2-johan+linaro@kernel.org/

and it is still sitting in Bjorn's queue.

Johan
