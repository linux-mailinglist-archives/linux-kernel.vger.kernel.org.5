Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3404179D871
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjILSMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjILSMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:12:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7257FE59;
        Tue, 12 Sep 2023 11:12:20 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 460C566072BA;
        Tue, 12 Sep 2023 19:12:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694542339;
        bh=nX3lsKQBlcGnc3y8PMLGwQiqS/ItArlngTMV0jgoqUI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=R4Dmjkpr/8WN94ZJoZJb+pffVzE2Dibdgj8zic9ALz6Qs/0MVXf9PUa2ceoDuUNNZ
         OX0CsU2ZCDrf3lxrMdT2UxkncMJI+dcudgRxW7mBq94xXRo9apV5t/rodFgWHnl/E0
         grRHKVrbf1hKz0Dg8Zb+ABnLcW2NEmnV+VPQu+01GstqNKIzocBWGLrcDlhefpNI6k
         k8q6xfwnt84L3Mv7XmScCkjI5TGDU6LqDvWtGWWE1C29M/JlLU6I97kstmtsEAVgNJ
         qdXjENRiXTEN7e6b2QijHRYc0u7NQ/8FysDRfc2EsA+nqs8/+o5otaHgdSA5dJKsBf
         0VawgdqVCTIDw==
Received: by mercury (Postfix, from userid 1000)
        id 9033E106098A; Tue, 12 Sep 2023 20:12:15 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823085601.116562-1-krzysztof.kozlowski@linaro.org>
References: <20230823085601.116562-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] power: reset: use capital "OR" for multiple licenses
 in SPDX
Message-Id: <169454233557.480809.2698811926965551954.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 20:12:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Aug 2023 10:56:01 +0200, Krzysztof Kozlowski wrote:
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
> 
> 

Applied, thanks!

[1/1] power: reset: use capital "OR" for multiple licenses in SPDX
      commit: 926ce6ba25101ccc659475e01ce5748374ab5856

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

