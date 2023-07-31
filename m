Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E6F76A275
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGaVLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjGaVLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E5D12B;
        Mon, 31 Jul 2023 14:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F166A61299;
        Mon, 31 Jul 2023 21:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A944C433C7;
        Mon, 31 Jul 2023 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690837910;
        bh=NaRfokbC5MctFNn+HQzdl3qpHCmFNXvgmJq9E6YDYgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYhrpxIp3aHzjGRww7Kp2OXYrzF85jlta5fLDzcym7rsxpAR2twEs92WZyCqTdnhF
         Zuwv4t5BqUBEfUmuAn3WjXvbgAyldpSmTMAzTUk64yvg2PP9SMoz+t6h8qQ+902N0b
         5J6ekUdJY21ldTk+vdfrzD8ZCxO8nHXwrdWl5VHgxgXW4D8DfpdHPWT0sYYq2q6394
         Zc0Uo7v8NOGzcVym5kLiYP5NDXR0vAA+2V4FDMooUzQHl1+lNMKWsQlgTpImtMc0z8
         DzS+a1nykU8nEB+H84ebXM8wq893qsesNM52fhr1YdzaTUyHIM9523J6XOgAs9Iylp
         D6NCNEPBt6mYA==
Date:   Mon, 31 Jul 2023 14:14:55 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Praveen Talari <quic_ptalari@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_vnivarth@quicinc.com, quic_arandive@quicinc.com
Subject: Re: [PATCH v7 1/2] soc: qcom: geni-se: Add SPI Device mode support
 for GENI based QuPv3
Message-ID: <dufutknk5hcqesx5s7b67vxpogevm452j3afewi3bcinbruoj6@iteug4rup7cm>
References: <20230714042203.14251-1-quic_ptalari@quicinc.com>
 <20230714042203.14251-2-quic_ptalari@quicinc.com>
 <76c4363a-e9fc-40c7-9c41-6a7a039aeb36@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c4363a-e9fc-40c7-9c41-6a7a039aeb36@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 02:11:42PM +0100, Mark Brown wrote:
> On Fri, Jul 14, 2023 at 09:52:02AM +0530, Praveen Talari wrote:
> > Add device mode supported registers and masks.
> 
> Does it make sense for me to take this one via spi given how trivial it
> is?

Sounds good to me.

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
