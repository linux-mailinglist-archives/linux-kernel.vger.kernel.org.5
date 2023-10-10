Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482E97BFEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjJJOTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjJJOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:19:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2BFAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:19:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB7CC433C7;
        Tue, 10 Oct 2023 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696947548;
        bh=wV9qLR8tcGG1yVmtAdC5FwrCHYOQ/XD+/G/hGQ4wcB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/eAGdndDZcrQO2bHbVRnmn49fjTqupzR/dBHlPRGJTtwuibqoA9ZMW1jnUNhHl+c
         j2aAFpyFlz+uopK5HSUJQ3K7/OK+TQlgg/nemrPBEG1AHYPO3sLYZdsFYRBvVwQzXm
         o2/HWEr72o1QFwYhZbSTYxk6hp4s4XXHkz6cOLzYbspaCF0PzqhFwKxmaHFSjGdZgT
         MTUVjiOUlGbsbCon4GqN7x8UPX6Zc2ZRcb7dBoPqiGqoNarPc6NDTy99tC2ItNXHMV
         T3i8nlKUgt0UVP1KFtHV2S0lCJFGyCQVtoLktlmS36L9TYL8fAjii9z+objw5/shwi
         7NK1jP5fbvwZQ==
Received: (nullmailer pid 819983 invoked by uid 1000);
        Tue, 10 Oct 2023 14:19:06 -0000
Date:   Tue, 10 Oct 2023 09:19:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sam Edwards <cfsworks@gmail.com>
Cc:     Sam Edwards <CFSworks@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel =?utf-8?Q?Kukie=C5=82a?= <daniel@kukiela.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add turing
Message-ID: <169694754552.818870.13308355883596740674.robh@kernel.org>
References: <20231007043600.151908-1-CFSworks@gmail.com>
 <20231007043600.151908-2-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007043600.151908-2-CFSworks@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 Oct 2023 22:35:58 -0600, Sam Edwards wrote:
> Add vendor prefix for Turing Machines, Inc.
> (https://turingpi.com)
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

