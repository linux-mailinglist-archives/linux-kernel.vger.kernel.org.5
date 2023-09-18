Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A027A4A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbjIRMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241990AbjIRMwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:52:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF09AA8;
        Mon, 18 Sep 2023 05:51:47 -0700 (PDT)
Received: from mercury (dyndsl-091-248-188-252.ewe-ip-backbone.de [91.248.188.252])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 315796607090;
        Mon, 18 Sep 2023 13:51:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695041506;
        bh=lp05snp62dGkHv23jHmptoObtM33UpdeDI7QoLPTN5g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W5FMbdkKAQTwACqLftqkNjgJVdXjY/tm/tXiGaqseI8C4RPQJeY5Np0mldWWtEiKK
         HYvFnA9MVIndWJCChNhiopljqIZ5TIClUgeOSTw/F451GnkTY4QTNLxRLg0IlLfE+1
         ge6xkGGJLpdgp6V6C9cA20cKaVKqlMsAYWQ+mlkGaQTIhJZGy5L4EnuHVnZ6QlB6vk
         budUWJXJbHK5I3g+6qLLrOT9P1iip6kH+0G7nTPobmysx9LjDz0eBLLMEPO7soNE7H
         isSLKus/LijQP2pcDWzHncvNg9B6phG+GGQJCbijLdfF9SKBgf00H7k4M4JxQPHLNA
         C7FUBiEgkUZMA==
Received: by mercury (Postfix, from userid 1000)
        id EFE6510604AD; Mon, 18 Sep 2023 14:51:43 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230917190124.1012316-1-sebastian.reichel@collabora.com>
References: <20230917190124.1012316-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCH] dt-bindings: power: supply: Drop deprecated
 ab8500-battery
Message-Id: <169504150396.1067255.1804972612705856796.b4-ty@collabora.com>
Date:   Mon, 18 Sep 2023 14:51:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Sep 2023 21:01:24 +0200, Sebastian Reichel wrote:
> Linus Walleij modified AB8500 to use the generic simple-battery
> and samsung,battery bindings. This is an unused leftover that
> can be removed.
> 
> 

Applied, thanks!

[1/1] dt-bindings: power: supply: Drop deprecated ab8500-battery
      commit: f392f3796bba1a160b8ad706bfe1e1ec3581ad48

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

