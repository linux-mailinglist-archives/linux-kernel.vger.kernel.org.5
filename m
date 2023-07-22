Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835F075D989
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjGVD7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGVD7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82726E74;
        Fri, 21 Jul 2023 20:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20DD561DCF;
        Sat, 22 Jul 2023 03:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ACEC433C9;
        Sat, 22 Jul 2023 03:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689998380;
        bh=ZBGteabbJw7m9fJtIyroIDjaZlrkeHej14zYPb+AQZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkxULteX7hOXv6e8m+NVSljQVNTrWpNaidT3vW2UNHaK/jQIjS2KpEieRtrLJGczd
         ixF9TmpCgWzxXhXj1HHKJAp3Ck2OsTj0A9K08J+/L/e/yKpsfhMjroxtlm0xkuNSSD
         xliVWgqW/WQALEeRb9pCkWwmWCmBcPfHEbe0uxvcyZahL/++LFbSayLxylrkbCLwjp
         +KRjc/HOdAf9o5aXmlsxcA9n3ov3zqroeQEJre+VwUYgIKg5l2+Qf19Wx+gwld2SW9
         ++JnrSw9M7qF338RzpVQI7CnEJ7ueG0IZagbFajm4BkktDbsXcNMapZDVVY+80yp7m
         h2XyUrVH6uAXQ==
Date:   Fri, 21 Jul 2023 21:02:59 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_saahtoma@quicinc.com
Subject: Re: [PATCH V2 1/2] dt-bindings: arm: qcom,ids: drop the IPQ5019 SoC
 ID
Message-ID: <e4fub7xxkiupbkszaxwu4x5otdi7afvyl334ybwlxafkbxfw3c@cd4gja5u6st6>
References: <20230712041912.398724-1-quic_kathirav@quicinc.com>
 <20230712041912.398724-2-quic_kathirav@quicinc.com>
 <20230714155954.GA3919199-robh@kernel.org>
 <dba8ab0a-c17b-8660-5c5a-803e7f394547@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dba8ab0a-c17b-8660-5c5a-803e7f394547@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 08:41:56PM +0530, Kathiravan T wrote:
> 
> On 7/14/2023 9:29 PM, Rob Herring wrote:
> > On Wed, Jul 12, 2023 at 09:49:11AM +0530, Kathiravan T wrote:
> > > IPQ5019 SoC is never productized. So lets drop it.
> > You need to remove the user before removing the definition.
> 
> Rob, Currently there are no users for this macro.
> 

But you're removing a user in patch 2? Or am I reading that incorrectly?

Regards,
Bjorn
