Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45A7A8A15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjITRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjITRKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CFAA3;
        Wed, 20 Sep 2023 10:10:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38006C433C7;
        Wed, 20 Sep 2023 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229807;
        bh=L5dipSB0QbCRhqx+MiTuajJzyrgEBRTz5u/dkrwFz3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exZrAPxvUxl+AwKrVp+aNuRKF6qbiUFdCeQdFkYwhep1uxyQoZGR9rEoyKkUeeWzg
         FpwfOjNCD5BeTStymzFygw5S53MZxauqpywEK88bzetqNqqJUxuPBqSMmKTtyiG2oh
         q3jz0ZSk9tTdqvvW5gvOaNbdaulSMo/PEk0WQyfej2b0oKTljwigwsI12BFmEnGo25
         wXxweOOblq/zfSTI9jFGsb8AmQPqgd37vpM+fgPdS6VyUG41OUmqCWX6z97ZtWOntE
         NcjR1miEx5nmsF64W68WlAO6tasjnfks/r06O2EDottwialrtFLFvsqI4EF5BYB/9n
         mnphFW8XFi6Iw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: pm8150l: Add wled node
Date:   Wed, 20 Sep 2023 10:13:56 -0700
Message-ID: <169523004973.2665018.13532332938289995058.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913185514.21840-1-danila@jiaxyga.com>
References: <20230913185514.21840-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2023 21:55:14 +0300, Danila Tikhonov wrote:
> WLED is used for controlling the backlight on some boards, add the node
> for it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: pm8150l: Add wled node
      commit: 4a94b52a47f63fb6db44871f446d31c28ca89bb9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
