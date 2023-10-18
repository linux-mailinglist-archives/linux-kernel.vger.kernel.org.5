Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AFC7CD8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjJRKQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjJRKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:16:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB90109;
        Wed, 18 Oct 2023 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697624179;
        bh=MczObw+G4xIfimfbL65IT/uzpdr8unY/SOxvHjaqltM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=A+53hsGmVyQYZZh5fTNgAkvKCl4uqq0LlfPKxFdLRnkUdS990MgFkzAD2DjBBG/+Q
         iR6t95IAePINUtlt5f7MPTjZsTbxoZc84zemN57VvwOvppCQUWAiTwL+dDCPCBzwNp
         EExN23l5P9uQgXwRCGn/gRCPGCbMO+ybjEW+N0JzOCkRYpoB+Y9jXwxYHRlZ5QjpIu
         r6RnQYtkK75SJmUNp3+jR8HHFvDOpWNLNFnYXsAkSTn6e8/QbiyAEr1NeTvVmFE4Fq
         X/Zdt++Imc1OXNlm/zP/AbR2ft0iMH1XypX8p8WP9w7EJ3UcpQrGTjpNFxtf5O8D8l
         NBLbv8iapuwcA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9RZp5lHmz4xF9;
        Wed, 18 Oct 2023 21:16:18 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>,
        martin.lau@linux.dev, yonghong.song@linux.dev,
        john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: powerpc: net: bpf_jit_comp32.c: Fixed 'instead' typo
In-Reply-To: <cc25e4b1-9079-1c45-b6d4-7f7f4701df0a@iogearbox.net>
References: <20231013053118.11221-1-m.muzzammilashraf@gmail.com>
 <cc25e4b1-9079-1c45-b6d4-7f7f4701df0a@iogearbox.net>
Date:   Wed, 18 Oct 2023 21:16:18 +1100
Message-ID: <87cyxc6xsd.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:
> On 10/13/23 7:31 AM, Muhammad Muzammil wrote:
>> Fixed 'instead' typo
>> 
>> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
>
> Michael, I presume you'll pick it up?

Will do.

cheers
