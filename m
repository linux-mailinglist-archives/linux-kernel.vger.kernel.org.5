Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CA07711A1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHES5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHES5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD71128;
        Sat,  5 Aug 2023 11:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DE160E08;
        Sat,  5 Aug 2023 18:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A6DC433C7;
        Sat,  5 Aug 2023 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691261831;
        bh=4+fL0hUNzE7Ka2DYNcBDDYAn9PKCYwrh2Lr+51H4lRc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EOESBsYidzyhgU0RwQLtf8lvkqHhgj4jPQGHAUqnxp5PW435sW/55o8tUVxhtzOli
         oAHyW7c+6h05RwS/83gFAm6tFUyFgUH9KfQnSyw7JgSSSJpnQvkZmRa9HhdjGVM1k4
         MmeMSjohh00ftifIioZ/+0ILuiR8XtEAZL0iBYaMWPCrwTyIKlrd1HlsUBnEbRVHdL
         YiDVtsUvxv/i7uAjlJiDt013OtkL30PmbPJN1veKaQy8CANryTpnNXuiD2fT1EbuHB
         dP9KYd25iMhBhp2e5l33N4fJSUkx2nGu13UONXTZ0KnsTLg4nORIRxt/nNrcVv4UE/
         o4koEvDkXo8jw==
Message-ID: <46e86c46-29b0-85eb-303d-7892d9d18b12@kernel.org>
Date:   Sat, 5 Aug 2023 21:57:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: Enable dual role support
 for Type-C port
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srk@ti.com
References: <20230725103651.1612-1-r-gunasekaran@ti.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230725103651.1612-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/2023 13:36, Ravi Gunasekaran wrote:
> USB0 is interfaced with a Type-C DRP connector and is managed via a
> USB PD controller. Add support for the Type-C port with dual data
> and power sink role.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
