Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A947D94C1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345702AbjJ0KIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345686AbjJ0KI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:08:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046E0191;
        Fri, 27 Oct 2023 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1698401301;
        bh=jtuCWNKuE/h7zD2BeBm3DoEXh/mgySFqwyRN11JrCB0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ECsiud9L4hpYSVBuhqqg+PWooHWULZGIoQRUwr5//eEDwnO6Pncwp3gV8iHlXu99w
         mpchcTlkkrMeiX+UXhquvTZKzHiW7QVJxkfjjebQ28rP464hoyEKw0BltCSj8elq6m
         6RhJvnOFv7CE3hBqwsfL+tLMCQ3FDh6NKCwgStvh/mYXizaaFlq60b+x9iLVCiImsb
         17YbMcNbby9awVq4fk6+cnfErbuZTiMamUzuOkNkbqDoq+MHSNxctHjGWTTqgLh6ij
         aDLNJVZnrtP3MJIKPhZ8u0Dj38PQPuq0Du7TS2mVYn3HW8Qqgtt06Jn/HbHjVoDSTE
         0XEcrTS/I8QBA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyzS6kLTz4xWn;
        Fri, 27 Oct 2023 21:08:20 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     martin.lau@linux.dev, yonghong.song@linux.dev,
        john.fastabend@gmail.com,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231013053118.11221-1-m.muzzammilashraf@gmail.com>
References: <20231013053118.11221-1-m.muzzammilashraf@gmail.com>
Subject: Re: [PATCH] arch: powerpc: net: bpf_jit_comp32.c: Fixed 'instead' typo
Message-Id: <169840079668.2701453.302685477788337592.b4-ty@ellerman.id.au>
Date:   Fri, 27 Oct 2023 20:59:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 10:31:18 +0500, Muhammad Muzammil wrote:
> Fixed 'instead' typo
> 
> 

Applied to powerpc/next.

[1/1] arch: powerpc: net: bpf_jit_comp32.c: Fixed 'instead' typo
      https://git.kernel.org/powerpc/c/4b47b0fa4b15e0de916e7dd93cd787fdab208ff2

cheers
