Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1164D7A0E64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbjINTcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjINTcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:32:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD926AB;
        Thu, 14 Sep 2023 12:32:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E312C433CC;
        Thu, 14 Sep 2023 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694719959;
        bh=289hKtCNGbmRY1pgYijaJkecvecKAL0wl8URb1/KOdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ooBZz6CExeH3F+bX3ACbr3jdqkBQUr/nl9gF3hLtxu1xft+2MqpVQb+KRri/y9Uhw
         8VqEUyFaTQjfGpqK0MwY8B/6nJtbtsBHUYpkoZJWXzRie3JiV4BI1kqQU+xP3VHura
         lYY522ao+8/BgyFbewoZj7u5OAgXXhFbajVIEQqXVN5V9ZdnjvOsY/cDuFryyH7Lgw
         lLe4ZVYSznByR8UigEXWyTm/waYM5WsSlNVhKtxNQ9bJK4ah4EWtOmVMfSk4ZEznkQ
         8cKsOjFa0NeSdNGYclju/YEcWc3XVXnC9OuaY4T/J1ayYGSv56hIGciRojIqAzjuRD
         oaetPBp5szUag==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [RESEND PATCH 1/2] firmware: qcom-scm: drop unneeded 'extern' specifiers
Date:   Thu, 14 Sep 2023 12:36:40 -0700
Message-ID: <169472019838.1902897.15847368480461533312.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913192826.36187-1-bartosz.golaszewski@linaro.org>
References: <20230913192826.36187-1-bartosz.golaszewski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2023 21:28:25 +0200, Bartosz Golaszewski wrote:
> The 'extern' specifier in front of a function declaration has no effect.
> Remove all of them from the qcom-scm header.
> 
> 

Applied, thanks!

[1/2] firmware: qcom-scm: drop unneeded 'extern' specifiers
      commit: 2758ac3a11d78af56e6969af04dec611806a62de
[2/2] firmware: qcom-scm: order includes alphabetically
      commit: bc7fbb5ea701b22c09c0fa5acbc122207283366a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
