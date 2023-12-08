Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C380AFEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjLHWwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHWwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:52:06 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44AA122;
        Fri,  8 Dec 2023 14:52:12 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3E79F5CC;
        Fri,  8 Dec 2023 22:52:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3E79F5CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1702075932; bh=Q5SH9C4+hpP8cVrBXq0MxSAa1TH7wdLONhP0/cB/JUQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kBK2F4B/afR48c0LIGEsLcwi2u6+nfMa46zsWBM5zF9r9KBjUzX3iYdb6eYlXD1q7
         W6NkBQ8m9R3P1XIS8LAcRFYh4gmsWYZ4tbsCpMXodxIyyZlG8rVgxJ3dMPn9Y21x9F
         TrmBTyYVAEvrqbcQ/DFc2S7y7nrpFe08R/lAJIeSaoOBXR1MJ15Chun0X3W78sTrbf
         HHw0QzoGvoIk42maurh4csDuh/heQ8QjglB38wbqBlzuLnyV2Q+lr5QnaYWQnFPPGk
         GPyk0gTIJKhlHZkiidDl0iIgjSt24j6MTKAx9fviOaBOsoPEEgsuz96vW6FLu367VP
         B+ZRZgJ5BvFRQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jens.wiklander@linaro.org, vegard.nossum@oracle.com,
        Rijo-john.Thomas@amd.com, balint.dobszay@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v3] Documentation: Destage TEE subsystem documentation
In-Reply-To: <20231128072352.866859-1-sumit.garg@linaro.org>
References: <20231128072352.866859-1-sumit.garg@linaro.org>
Date:   Fri, 08 Dec 2023 15:52:11 -0700
Message-ID: <87fs0c489w.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sumit Garg <sumit.garg@linaro.org> writes:

> Add a separate documentation directory for TEE subsystem since it is a
> standalone subsystem which already offers devices consumed by multiple
> different subsystem drivers.
>
> Split overall TEE subsystem documentation modularly where:
> - The userspace API has been moved to Documentation/userspace-api/tee.rst.
> - The driver API has been moved to Documentation/driver-api/tee.rst.
> - The first module covers the overview of TEE subsystem.
> - The further modules are dedicated to different TEE implementations like:
>   - OP-TEE
>   - AMD-TEE
>   - and so on for future TEE implementation support.
>
> Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> - Rebased to docs-next
> - Fixed dangling references to Documentation/staging/tee.rst.
> - Applied tags.

Applied, thanks.

jon
