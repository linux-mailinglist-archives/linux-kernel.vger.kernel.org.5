Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9679D953
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbjILTI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjILTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:08:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2842AE6;
        Tue, 12 Sep 2023 12:08:20 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE37C6607314;
        Tue, 12 Sep 2023 20:08:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694545698;
        bh=/VzjWlv3CMIeZ23/9Hp8VPg17hQMxbujmnekoWivzMw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g5BaF/qhbYhFMSnik3Th7pf7rovQBEJbNopX1Ik+9Ae2+9ZjxjaENhqCP0qxS2EzK
         tlRdN4w+gxqt96riK8oMqZssVBY6wr6ZJb7shUzwPa1DE3X60JFZzBpHrL1voHTuxH
         ts+DHQ/VIz/fSCrGJ6dlvZFEiIoaLdkH/kr0knp3IDQLwXH4xdymom8jkgmKhhZ1vb
         VuJvqHACM9HAcp8RZJafU76Xqd+MBrNsmRl5gDM5jxXyZnpDI/fDt1qiZC8pZeFqEm
         pfxxvN29zf0e7d5YXNoOXLrOEYXJw2Mv/2J04rsWnpgdkEGZwh/7XJ/eUgTkHJ9vy4
         kzXeHhbUJvPsA==
Received: by mercury (Postfix, from userid 1000)
        id 5D507106098B; Tue, 12 Sep 2023 21:08:13 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     hdegoede@redhat.com, krzysztof.kozlowski@linaro.org,
        m.szyprowski@samsung.com, sebastian.krzyszkowiak@puri.sm,
        kernel@puri.sm, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Przemyslaw <przemekchwiala@gmail.com>
Cc:     lukas.bulwahn@gmail.com
In-Reply-To: <20230720123102.154699-1-przemekchwiala@gmail.com>
References: <20230720123102.154699-1-przemekchwiala@gmail.com>
Subject: Re: [PATCH] power: supply: max17042_battery: Do not use CONFIG_
 prefix in regular C code
Message-Id: <169454569337.510054.9386354023657535077.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 21:08:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Jul 2023 14:31:02 +0200, Przemyslaw wrote:
> Using CONFIG_ prefix for macros is not a good practice.
> Use CONFIG_ prefix in Kconfig only.
> 
> 

Applied, thanks!

[1/1] power: supply: max17042_battery: Do not use CONFIG_ prefix in regular C code
      commit: c06a65ac4e4945478f46654920f5af1be1cf384e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

