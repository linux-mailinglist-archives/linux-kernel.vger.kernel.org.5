Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF88577A6F3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjHMOc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMOc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:32:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC721707;
        Sun, 13 Aug 2023 07:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 008DC62643;
        Sun, 13 Aug 2023 14:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99742C433C8;
        Sun, 13 Aug 2023 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691937146;
        bh=cxE115GrNLsaVMkE1XjZDlSwZgzXqNCJwIdv8knppJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6PlTq59hKgj+RjhOB+ahakaoVv5X74D5yppBwexog3YNeyvOHROaQdxqJl4b92I9
         7rzZ4L26JPgyRFPsjsX6Qnh5bs+XsRFxZtZInOnhexmhn8x1xn3TBKzOa90JqU6Mhi
         FlWSvDW8nx3rQLNIfnbVdBF+Vkx9m2XzGE0fCQgrkStlkA7EcZMUfGK/vxZK2C2M4i
         I+eAITqdTE0FacNEm/Cl8cR9p5TwE5y5dyUqxasimWIQ6GVcDzgyDore8Wx2ggyVqj
         fb/BcaLQjUhhdShae+Zjnb5CxFbIpj7VzsUEJXRJs2jWVHvhaw9PkbOxznoHnURama
         3U30i1esP+adw==
Date:   Sun, 13 Aug 2023 20:02:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: sm8450: Enable sync_state
Message-ID: <ZNjpdceH4wWyoiHy@matsya>
References: <20230811-topic-8450_syncstate-v1-1-69ae5552a18b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-topic-8450_syncstate-v1-1-69ae5552a18b@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-08-23, 19:34, Konrad Dybcio wrote:
> Enable sync_state on sm8450 so that the interconnect votes actually mean
> anything and aren't just pinned to INT_MAX.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
