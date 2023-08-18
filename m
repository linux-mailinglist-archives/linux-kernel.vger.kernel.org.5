Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604A1780A47
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376337AbjHRKgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376391AbjHRKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6374046A0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 011E8640A4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E799C433C8;
        Fri, 18 Aug 2023 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692354884;
        bh=/I3yUOIPMAIf2jjLMU6pOK7vn2U3Nj4w+dTf8ovxlqg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vIujnUmnl1Xl08zeTpNMTHYWcZ6sO8mMvpILvF0KyD58Idulrnx97mXI/Pw2mx6Ti
         yNsJpdxeINKjDHu7BNaIyJRfEARB16L0MuaWJ0JuyF2dHgGJ1b7qh70mfGvfvxpbQM
         J2NSNyKaBoAi6llHGn/zhbHyFJ3D5YaBIbcAplF2lLesdP0hqh5u3yrRp2LQ6CzArS
         OF3FgZeWEUbwDflVvRY5zs2hDGcHs0V1N1/ioi/OjJEqok26oEHzessvR0TvR+4aQ9
         LW7XICfOI6liNQYhprgnXR4sDXc6HxSK1Ek6Fh+Jr41wyPY5+hNGfau//ksR6pMRMT
         PKuAEomKqVQpA==
Message-ID: <a176dfff-1d03-f3c4-aa6c-47d6c3335c30@kernel.org>
Date:   Fri, 18 Aug 2023 12:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 17/17] arm64: dts: ti: k3-am62-main: Add GPU device
 node [DO NOT MERGE]
Content-Language: en-US
To:     Sarah Walker <sarah.walker@imgtec.com>,
        dri-devel@lists.freedesktop.org
Cc:     matthew.brost@intel.com, luben.tuikov@amd.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, mripard@kernel.org, afd@ti.com,
        boris.brezillon@collabora.com, dakr@redhat.com,
        donald.robson@imgtec.com, hns@goldelico.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
References: <20230816082531.164695-1-sarah.walker@imgtec.com>
 <20230816082531.164695-18-sarah.walker@imgtec.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230816082531.164695-18-sarah.walker@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 10:25, Sarah Walker wrote:
> Add the Series AXE GPU node to the AM62 device tree.
> 
> Changes since v4:
> - Remove interrupt name
> - Make property order consistent across dts and bindings doc
> - Fixed formatting (replaced spaces with tabs)
> 

Nope, DTS go via SoC tree. You skipped all lists and maybe also all
maintainers.

Really, start finally using the Linux tools - scripts/get_maintainers.pl


Best regards,
Krzysztof

