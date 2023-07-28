Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BCE766B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjG1K7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjG1K7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB62701;
        Fri, 28 Jul 2023 03:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B8F0620D2;
        Fri, 28 Jul 2023 10:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C13FC433C7;
        Fri, 28 Jul 2023 10:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690541944;
        bh=Q/3dxIdzBnErliQ/+hQ/dImf3Dbz4FBTVsuqEEmFhkA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=QwxQTDqt5h4eSQ3IdO2/LZ5O/5J8aqCKqMiC7ysixf9FLiobtfBerV4KNuLxDJKyN
         +IP9GR9cecfaYXgGVVaA68OWS9P6/ZenMmbCRQsW4pB0ndZt0feMxz1mrS6MinH3Bf
         BU1ySzf46n6JPIsvDHOD/7A2pS5+Rc3jiy9gquK9CBIB3usuSPkv02ZiCPOKpgL6f+
         YhZltpvlLKH+4ufbIWY7oA2WHwT+wWrgo9oi3IU5n40G8rxdpU7Oqj7rSlKV58cXW7
         qVnQ77gMawl+F0fR/Dcm3hEhaZ31bcnjXJN8xJIv7P8+PhZ76fuqT3F8k8MnQejnPQ
         yAK5SsShAtbFg==
From:   Lee Jones <lee@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230723070715.34650-1-krzysztof.kozlowski@linaro.org>
References: <20230723070715.34650-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: maxim,max77693: add USB
 connector
Message-Id: <169054194322.338813.14351038021250910187.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 11:59:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2023 09:07:15 +0200, Krzysztof Kozlowski wrote:
> Add micro-USB connector to properly represent the hardware.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: maxim,max77693: add USB connector
      commit: 010a847013c1d72d09dbf951530dcb4335028632

--
Lee Jones [李琼斯]

