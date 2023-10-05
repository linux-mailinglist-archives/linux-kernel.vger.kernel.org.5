Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC107BA18F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbjJEOs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjJEOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:45:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5268CB289
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:27:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A081DC36AEE;
        Thu,  5 Oct 2023 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696511538;
        bh=QduHmCzbU5Uk4CzWx0snf3swDgq3DpWkZbbsI8nxfWM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Th7AxuHjOiCMIOtKtdUp14zEny08Ra2TpDWc0akkkMSMgOcu3RrBcau2fJAbX1al3
         CeYxFpv+5Z9tOOo3KhWkj0kExDCTlnAAN2jcYsa4DDQU1Cig+Hqpj1xO66N18SRFUD
         t2w8FWAKp9nHOVLw/6axmBzI++FQv5/ta93ZKmdN8AxD/0S3tRspIyUicCNZtze4e6
         DpNIECwG4O8PSNM3VWROy4JTF9K0VwyPl5kG8Je3j9HDamPbuhECYn/s2pRWe7qrQ7
         pBMz78oFugi/gyjbk+5y57RWG9xzpnUzO6gKmEeG/LNS0pGSEGBdmrxy80EmJfBQnu
         YpvzyNB92KOSQ==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20231001-mfd-rk88x-maple-v1-1-90434cfb2f90@kernel.org>
References: <20231001-mfd-rk88x-maple-v1-1-90434cfb2f90@kernel.org>
Subject: Re: (subset) [PATCH] mfd: rk8xx: Convert to use maple tree
 register cache
Message-Id: <169651153737.756680.8608100684056803745.b4-ty@kernel.org>
Date:   Thu, 05 Oct 2023 14:12:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Oct 2023 00:44:22 +0100, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> 

Applied, thanks!

[1/1] mfd: rk8xx: Convert to use maple tree register cache
      commit: 2341a4f343e90f3fcc49ff3a49610d251b4c2532

--
Lee Jones [李琼斯]

