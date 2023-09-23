Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1003F7AC53D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIWVpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 17:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWVpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 17:45:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE2180;
        Sat, 23 Sep 2023 14:45:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF6DC433C8;
        Sat, 23 Sep 2023 21:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695505545;
        bh=fS4DH7h2XPXh7V4XUcE3VlGOmmyl+giuc/McST8xN70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JIpYfalFeiVszYfw5kNLb41uMt+H7QBVrBkJrb6PelynhbpgrFRQYz1WB5ctlyKN5
         iE36M6TDf1fGKR5cxIaSwfHEvpM7sNG8N297H6cVjXbjfg9bfs1gMNBF8BPwC/OBds
         FuP22HNG1Y6n/yVfeT01x415DHxQGoB3u4msYyyU54J0Yvsn3DWW4qG8ujunjLgusM
         TiTTkZ3Oaml6xeau+VeiKYKJP3pomc4ZIzg+ZKFwqf56Rfal4QVmF1gq6fkoyREh+x
         SA23nSICZyKMhzKupqL/N9KE1k8iXVDkBAVxlgeHcNPoXAT8VGJnnJgk8moNPT59Iv
         KFSZ20ClFyeNQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: sdx65-mtp: Specify PM7250B SID to use
Date:   Sat, 23 Sep 2023 14:49:48 -0700
Message-ID: <169550521468.6100.14904156607688324657.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230921-pm7250b-sid-fixup-v1-1-231c1a65471f@fairphone.com>
References: <20230921-pm7250b-sid-fixup-v1-1-231c1a65471f@fairphone.com>
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


On Thu, 21 Sep 2023 08:34:02 +0200, Luca Weiss wrote:
> Now that the pm7250b.dtsi can be configured to be on a different SID, we
> also need to specify it for this dts file. Set it to the SID 2/3 like it
> was before commit 8e2d56f64572 ("arm64: dts: qcom: pm7250b: make SID
> configurable").
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: sdx65-mtp: Specify PM7250B SID to use
      commit: 4d8b5d7171722d2cdccc880d8e449f7ca9c7b6bf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
